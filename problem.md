Streaming binary record parsing

Parser instances must support decoding framed records from chunked binary input without requiring callers to reconstruct complete buffers.

1. `parseStream(source, options?)` must return an async iterator that accepts synchronous or asynchronous iterables of `Buffer` and `Uint8Array` chunks and emits records in input order across arbitrary chunk boundaries.
2. Parsers with a positive static `sizeOf()` must use that size as the default frame length; other parsers must require `frameLength` as a positive safe integer or a resolver whose result includes the entire frame.
3. A frame-length resolver must receive the currently buffered bytes, treat `null` or `undefined` as needing more data, and reject any other non-positive or non-integer result.
4. Each complete frame must be parsed exactly once, and parsed binary fields must use the constructor of the first non-empty input chunk.
5. `createStream(options?)` must provide the same decoding behavior for push input through `write`, `end`, and `abort`, while remaining an async iterator.
6. `write` must apply result backpressure at `highWaterMark` until the queued result count falls below the limit.
7. `maxBufferSize` must bound incomplete buffered data without rejecting a larger chunk composed entirely of complete bounded frames.
8. Complete records must remain consumable before a trailing source, parser, or incomplete-frame failure is reported.
9. Stream failures must use `ParserStreamError` codes for aborts, buffer overflow, incomplete frames, invalid frame lengths, and writes after closure, with applicable byte counts exposed on the error.
10. Abort signals and early iterator closure must stop attached sources, and closure must reject further writes or endings.
11. Streams must expose their buffered byte count, queued result count, and closed state.
