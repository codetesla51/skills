---
name: "go-codebase-cleanup"
description: "Audit Go codebases and aggressively simplify AI-generated defensive over-engineering into boring idiomatic Go"
version: 1
created: "2026-09-11"
updated: "2026-09-11"
---
## When to Use
Use when auditing, cleaning, or reviewing a Go codebase for AI slop, defensive over-engineering, excessive abstraction, generic maps, or helper/interface sprawl. Goal is boring explicit strongly-typed idiomatic Go: validate untrusted data at the boundary, concrete types everywhere else.

## Procedure
1. Work feature-by-feature: find where data enters (HTTP, queue, DB, config, webhook), give it a concrete struct type, validate/decode once, then follow it through
2. Remove unnecessary any/interface{} and map[string]any: if JSON shape is known unmarshal directly into struct; fix Mongo/Redis models with bson/json structs at the data-access boundary
3. Delete generic conversion helpers (toString/asString/safeString/valueOrDefault/GetString etc) — ask what type it actually is, fix upstream type so helper disappears
4. Remove fallback-to-zero programming (silent return of empty/0/false/nil) — return error if required data missing; fix caller so nil is impossible where it should be
5. Remove nil-check spam and pointer spam (*string/*bool/*int for required fields) — redesign types with value fields so required values cannot be nil
6. Inline pointless single-caller helpers (getDomainID/extract*/resolve*/buildKey) that only access a field, trim, or assert
7. Collapse interfaces without reason: no FooService/FooImpl with one impl, keep interfaces small and consumer-defined; delete factories/builders/functional-options/managers/processors that just forward
8. Collapse pass-through layers (handler->controller->service->manager->repository->store) that only do return dep.Do(...); keep one meaningful layer
9. Simplify errors: return repo.Get directly, wrap only with meaningful context (load project %s), no giant custom hierarchies — use var ErrX + errors.Is/As; never swallow errors silently
10. No reflection, no generics (Ptr/ConvertSlice/SafeCast/GetOrDefault), no regex for strings ops, no reimplemented stdlib — use strings/slices/maps/strconv/errors/cmp
11. No duplicate DTOs (Request/DTO/Input/Params/Model/Entity for same shape) and no toDTO/fromModel mapper fleets without representation difference; pass only needed args, no single-field Options structs
12. Straightforward control flow: early returns over deep nesting, no useless temps, no ==true/false, var nil slice over make([]T,0) unless writes need it, no defensive copies
13. Context correctly: pass caller ctx through I/O, never nil-check ctx, timeouts only at meaningful boundaries; concurrency only when it benefits, no channel architecture for sync work
14. Keep logging simple: meaningful failures/transitions only, not enter/leave narration; delete obvious comments, keep why-comments; kill utils/helpers/common catch-alls, group packages by domain

## Pitfalls
- Do not replace one slop with another — e.g. turning a blind type assertion into verbose ok-checks instead of a typed struct
- Do not remove idiomatic Go: if err != nil return err, real nil handling, boundary validation, defer rows.Close()/resp.Body.Close(), tx rollback, mutexes for real shared state, driver error handling
- Do not line-golf — shorter because concepts disappeared, not because expressions were compressed
- Do not use recover()/panic for normal errors; recover only at genuine process/request boundaries
- Do not add goroutines, channels, sync.Pool, or caches without measured need
- Do not log-and-return the same error at every layer; log once at handling boundary

## Verification
1. Can an engineer trace behavior without jumping through unnecessary abstractions?
2. More concrete structs, fewer any/maps/assertions/helpers/interfaces/forwarding layers
3. go test ./... passes, go vet ./... clean, gofmt applied, behavior unchanged