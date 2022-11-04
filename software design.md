Agile approach enables solid architecture, which enables agile approach ad infinitum.

Orthogonal domain logic (not specific to application)
. stateless domain logic
    . ideally stateless pure functions
    . matches domain problem as directly as possible
    . deterministic and testable in isolation
    . robust to change over time
. separate domain logic from I/O
    . [[hexagonal architecture]] 

. store state and immutable event log
. embrace asynchrony
    . invert from sync call graph to async data flow

. incremental changes
    . decompose every large change into small incremental steps
. multiple versions coexist
    . changes are on a rolling upgrade
    . transitional states between versions are normal, not exceptional
. why evolve at all?
    . context changes, more clients, bigger organization, new constraints, new opportunities
    . problem evolves, domain understanting increases, competition
    . solution evolves, decomposition, technologies

# 80 / 20 design
[[pareto principle]]
@randyshoup

. big design up front doesn't work
. no design up front doesn't work
. 80 / 20 design
    . minimal design to get us started
    . pilots and prototypes
    . adapt based on real world feedback
    . get and incorporate real world feedback as early and as often as possible


Complexity increases exponentially, depending on how well we handle it we reach cognitive limit either sooner or later. This allows either more room for functionality or less.

[[modular design]]
