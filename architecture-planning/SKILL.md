---
name: "architecture-planning"
description: "How to help Uthman plan software architecture. Boring-first, failure-mode hunting, one recommendation."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# Architecture Planning

## Default stance: boring wins by default

The starting assumption for any architecture decision is the simplest, most boring option that could work — not the most scalable, not the most impressive, not the newest. Boring technology has a well-documented benefit that novel technology doesn't: its failure modes are already known. When Postgres breaks, thousands of people have hit that exact error before you. When a brand-new framework breaks, you're often the first.

This is the "innovation tokens" model (Dan McKinley, "Choose Boring Technology"): a project has a small budget for genuinely novel technical risk — maybe 2-3 tokens total. Spend them only where the novelty is the actual point of the project (e.g., kyfram's declarative video engine is a legitimate token spend — that's the differentiator). Don't spend a token on the database, the queue, the deploy pipeline, or anything else that isn't the reason the project exists.

**Concretely:** default to Postgres over a novel database, a single binary/monolith over microservices, a cron job over a distributed job queue, synchronous calls over an event bus — until there's a specific, demonstrated reason the boring option breaks down at the actual scale/requirements in front of you. "It might not scale later" is not a demonstrated reason; a specific numeric requirement that the boring option can't hit is.

## The process

1. **State the actual requirement first**, in plain terms — not the architecture, the problem. What has to be true for this to work? (e.g., "needs to handle X writes/sec," "needs to survive a single server dying," "needs to be editable by a non-programmer.")
2. **Propose the boring option first**, always, even if it's obviously going to be rejected. This isn't a formality — it forces the complex option to justify itself against a concrete baseline instead of against "nothing."
3. **Find where the boring option fails**, honestly. This is the ATAM-style step: walk through specific realistic scenarios (load spikes, a dependency going down, a bad deploy, a malicious input) and ask "what happens here, specifically?" Don't hand-wave this — name the actual failure.
4. **Only then consider the more complex option**, and only if it fixes a failure mode that the boring option genuinely can't handle. If the complex option introduces new failure modes of its own, name those too — complexity isn't free even when it fixes something.
5. **Recommend one option**, not a menu. If the boring option holds up under step 3, recommend it and stop — don't list five architectures for the sake of thoroughness when one clearly wins.

## Finding failure modes — what to actually check

For any proposed architecture (boring or not), walk through these before recommending it:

- **Single point of failure** — what's the one thing that, if it goes down, takes everything down with it? Is that acceptable at this project's actual stakes?
- **What happens under load** — not "can it scale infinitely," but "what's the first thing that breaks, and at roughly what point?"
- **What happens when a dependency is unavailable** — a third-party API, a database connection, a network partition. Does the system degrade, queue, or hard-fail?
- **What happens with bad/malicious input** — the nil-map/out-of-bounds instincts from the Go safety skill apply at the architecture level too: what's the equivalent of an unchecked array index, but for the whole system?
- **What's the blast radius of a bug** — if there's a bug in this component, what else does it take down? Tighter coupling = bigger blast radius.
- **What does recovery look like** — if this breaks at 3am, is the fix "restart the process" or "reconstruct state from three different systems"? Favor architectures with boring, well-understood recovery paths.
- **What does it cost to change your mind later** — some boring choices are also the easiest to migrate away from later (a monolith is usually easier to split up than a premature microservice split is to undo).

## Researching the actual options

Don't rely on memory alone for current tooling comparisons (versions, current best practices, and tool popularity shift) — look up real current information on the specific tools/patterns being weighed before recommending one, especially:
- Current maturity/adoption of a specific tool being considered (is it still actively maintained, how many known production failure modes are documented)
- Direct comparisons between the boring option and the alternative for the specific concern in question (e.g., "Postgres LISTEN/NOTIFY vs a message queue for this exact workload," not a generic "SQL vs NoSQL" take)
- Known failure stories / postmortems for the pattern in question — real incidents are the fastest way to find failure modes that theory alone won't surface

## What to avoid

- Don't default to "microservices," "event-driven," or any specific trendy pattern because it's common in blog posts — the pattern is only worth it if it fixes a specific, named failure mode of the boring option.
- Don't recommend a technology because it's what a big company uses — Uthman is not operating at that company's scale, and their architecture is solving their scale's problems, not his.
- Don't present novel architecture as "the standard approach" without flagging that it is, in fact, the more complex option — always name which side is boring and which is the token spend, so the tradeoff is visible.
- Don't skip the failure-mode walkthrough because the boring option "obviously" works — obvious is exactly where things get missed.