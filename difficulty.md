Difficulty target: Exceptional, long-horizon Olympus challenge

Expected top-tier agent success rate: 5-15%

Rationale: The change crosses parser sizing, binary representation, incremental buffering, synchronous and asynchronous iteration, push and pull consumption, backpressure, cancellation, source cleanup, and error ordering. A correct implementation must preserve already decoded records while delaying terminal failures, bound only incomplete data, avoid duplicate formatter or parser execution, and remain compatible with both Node Buffer and browser-oriented Uint8Array inputs. The reference solution changes four implementation files and contains more than 420 meaningful lines.
