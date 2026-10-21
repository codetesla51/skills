# Mocking properly in Go

A mock is a lie you tell the code under test. A good one is a faithful lie that can
also fail on demand. A bad one returns what the test expects and proves nothing.

## Contents
- When to mock and when not to
- Pick the right kind of double
- Define small interfaces at the consumer
- Hand-written fake with failure injection
- HTTP and third-party APIs
- Time, randomness, and I/O
- Assert outcomes, not calls
- Keep fakes honest
- Mocking smells

## When to mock and when not to
- **Do not mock what the project owns:** its database, queue, cache, or its own
  packages. Use the real thing (see `checklist.md`, Postgres section). Mocks hide
  constraints, locking, transaction behavior, and query quirks.
- **Mock at the boundary of things you cannot run or control:** third-party HTTP
  APIs, payment providers, email/SMS, the system clock, randomness, slow or
  flaky networks, and failures you cannot trigger on demand.
- **Never mock the code under test**, or pure helper functions next to it. Call them.
- If a test needs more than two or three mocks, the design is probably tangled.
  Say so in the report instead of piling on mocks.

## Pick the right kind of double
| Kind | What it does | Use for |
|---|---|---|
| Stub | returns canned values | simple inputs the test does not care about |
| Fake | working lightweight implementation (in-memory store) | most cases; behaves like the real thing |
| Spy | a fake that records calls | when the call itself is the behavior |
| Mock | verifies expected calls and fails if they differ | rarely; couples the test to the implementation |

Default to a **fake**. Reach for a strict mock only when the behavior is the call
itself ("charge is sent once, with the idempotency key").

## Define small interfaces at the consumer
Define the interface in the package that uses it, with only the methods it needs.
Do not create a big interface just to make something mockable, and do not mock a
concrete type you can run for real.

```go
// in the package that sends receipts, not in the email package
type Mailer interface {
    Send(ctx context.Context, to, subject, body string) error
}
```

## Hand-written fake with failure injection
Every fake must be able to fail on demand. Without that, the failure paths of the
code under test stay untested.

```go
type fakeMailer struct {
    sent []sentMail
    err  error         // set to make Send fail
    delay time.Duration // set to simulate a slow dependency
}

func (m *fakeMailer) Send(ctx context.Context, to, subject, body string) error {
    if m.delay > 0 {
        select {
        case <-time.After(m.delay):
        case <-ctx.Done():
            return ctx.Err()
        }
    }
    if m.err != nil {
        return m.err
    }
    m.sent = append(m.sent, sentMail{to, subject, body})
    return nil
}
```

Use it in table tests, including the failure rows:
```go
{name: "mailer down returns error and does not mark receipt sent", mailerErr: errBoom, wantErr: errBoom, wantMarked: false},
{name: "slow mailer respects context timeout", mailerDelay: time.Second, ctxTimeout: 10*time.Millisecond, wantErr: context.DeadlineExceeded},
```

Generated mocks (mockery, uber-go/mock) are fine when you need call verification;
the same rules apply: configure failures, assert outcomes.

## HTTP and third-party APIs
- Use `httptest.NewServer` and point the client at its URL. Test the real client
  code over a real HTTP connection instead of mocking `http.Client`.
- Return realistic payloads. Copy real responses (with secrets removed) into
  `testdata/` fixtures instead of inventing simplified JSON.
- Always test the unhappy responses: 4xx, 5xx, 429 with `Retry-After`, malformed
  JSON, empty body, truncated body, slow response, connection closed mid-body,
  and duplicate delivery of the same webhook.
- To fail at the transport level, use a custom `http.RoundTripper` that returns an error.

```go
srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(http.StatusServiceUnavailable)
}))
defer srv.Close()
// point the client at srv.URL and assert the retry/backoff/error behavior
```

## Time, randomness, and I/O
- Inject a clock (`type Clock interface{ Now() time.Time }`) and a fake that you
  advance by hand. Never `time.Sleep` in tests.
- Inject random sources and ID generators.
- For file and network failures, use readers/writers that fail after N bytes
  (`iotest.ErrReader`, `iotest.TimeoutReader`, or your own).

## Assert outcomes, not calls
- Assert what the code returned and what changed (rows stored, state, emitted
  events), not how many times a method was called or in what order.
- Assert calls only when the call is the behavior, and then assert the arguments
  that matter, not just that it happened.
- Over-specified mocks make refactors break tests without catching bugs.

## Keep fakes honest
A fake that behaves differently from the real thing gives false confidence.
- Run the same test suite against both the fake and the real implementation (a
  contract test) when the real one can be run, for example the fake store and a
  real Postgres.
- Make the fake enforce the real rules: uniqueness, not-found errors, ordering,
  validation.
- Re-check fixtures against the real API now and then (sandbox or recorded
  response) so they do not drift.

## Mocking smells
- The mock returns X and the test asserts X.
- No test makes the mock return an error.
- Test passes even after you delete the logic under test (check with manual
  mutation: if the mutant lives, the mock is doing the work).
- Mocks for things the project owns, such as its own database.
- Mocking `http.Client` or `*sql.DB` directly instead of using `httptest` or a real database.
- Strict call-order expectations on mocks.
- A huge setup block that is longer than the test itself.
