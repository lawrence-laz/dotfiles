partial ordering: time/events are related to each other as graphs of dependencies
total ordering: time/events are related to each other as a sequence of steps

atomic op: op which is observed to either happen fully or not at all (no in-between)
atomic variable: memory location which atomic ops happen to
data race: non-atomic ops from 2+ threads on same memory location where one op is a write

load: an atomic read to observe a value
store: an atomic write to publish a value
read-modify-write (rmw): a read, updating the value, then a write, all atomically
compare-and-swap (cas): a conditional rmw that may fail if the value was changed
weak vs strong cas: strong = fails if value changed; weak = can fail spuriously/randomly.

evaluation order: total ordering of statements on the current thread
sequenced before X: an evaluation is partially ordered before X on the current thread

modification order: sequence of all atomic ops on a given atomic variable
write coherence: writes happen in a sequence on a modification order
~~read coherence: reads are unordered between each other but happen/sequenced in between writes~~ (TODO: better wording)

release sequence: writes on a modification order that use Release memory ordering
synchronizes with X: Acquire read on a modification order that observes a Release'd write X 
happens before X: either sequenced before X, synchronizes with X, or sequenced before an op that synchronizes with X

Relaxed: op is atomic and participates in an atomic variable's modification order
Acquire: same as Relaxed, but only on reads and ensures observed Release values (& sequenced before writes) happen before it
Release: same as Relaxed, but only on writes and ensures sequenced before writes happen before an Acquire which observes the value
AcqRel: same as Acquire + Release; only used on rmw since its both an atomic read and write

SeqCst: same as Acquire on loads, Release on stores, and AcqRel on rmws
NOTE: atomic op also pariticipates in the global SeqCst ordering / modification order.
NOTE: SeqCst doesn't guarantee happens-before across atomic variables, only that the ops are in the same modification order.
NOTE: SeqCst doesn't guarantee Release on loads or Acquire on stores, only that the ops are in sequence on the global SeqCst ordering. 
