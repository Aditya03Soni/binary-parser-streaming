# Streaming Binary Parser Challenge

This folder contains a coding challenge for adding streaming record parsing to [`keichi/binary-parser`](https://github.com/keichi/binary-parser).

The challenge is pinned to commit:

```text
d7dc356679f393e767ef11f6c9eddfb0240e89e6
```

## Goal

The proposed change lets a parser read binary records from small `Buffer` or `Uint8Array` chunks. It covers pull-based input with `parseStream()` and push-based input with `createStream()`, including framing, backpressure, buffer limits, errors, cancellation, and source cleanup.

The complete public requirements are in [`problem.md`](problem.md).

## Files

- `problem.md` — the required public behavior.
- `test.patch` — the submitted tests and challenge runner changes.
- `solution.patch` — the submitted reference implementation.
- `difficulty.md` — the intended difficulty and rationale.
- `repo_url.txt` — the upstream repository and pinned commit.
- `Dockerfile` — the supplied test environment.

The patch files are the submitted artifacts. Apply them to a clean checkout of the pinned commit when reproducing the challenge.

## Review result

**Status: Fail**

The patch artifacts matched the inspected changes. All 16 new tests failed on the original code and passed after applying the solution. The repository's 166 existing tests also passed. However, additional checks found important behavior that the supplied tests missed:

- `Uint8Array` streaming can crash in browser-like environments where the Node.js `Buffer` global does not exist.
- Multiple writes waiting for backpressure can remain stuck after enough records are consumed.
- Invalid numeric frame lengths throw the wrong error type.
- Pre-aborted sources and failures during source cleanup are not always handled correctly.
- The Docker setup can fail when run by an arbitrary non-root user because the build needs to create `dist` in a root-owned directory.
- Repeatedly receiving very small chunks can cause quadratic copying and severe slowdown.
- The tests bypass parts of the public TypeScript interface and therefore allow incomplete implementations to pass.
- Some tests require exact property names, error codes, or wording that `problem.md` does not fully define.

Passing the supplied tests is therefore not enough to show that the implementation satisfies the full challenge contract.

## Verified checks

- The saved patches matched the intended repository changes.
- New tests fail on the base commit and pass with the submitted solution.
- Repeated solved runs were deterministic.
- Existing repository tests still passed.
- Tests ran without network access.
- JUnit output preserved individual test failures and names.
- Report-generation failure returned a nonzero exit status.
- No unrelated or artificial changes were found in the solution patch.

## Important note

This README records the review outcome. It does not modify or correct `problem.md`, `test.patch`, `solution.patch`, or the submitted implementation.
