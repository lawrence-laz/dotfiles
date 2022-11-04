## Day 1

### Bits and Pieces of Great Architecture by Jorge Ortiz-Fuentes @jdortiz

```
It's important to keep presentation logic separated from domain logic.
This can be done using MVVM. Be careful not to mix in domain logic into your ViewModels.
Call use case commands into domain instead.
```
Architecture is not for:
 - Selling product
 - Showing off
 - Bossing people around on how to do things

It is like martial arts - you repeat motions achieve same (good?) results (?).

Importance of separating UI logic from domain logic.
Examples using MVVM.
 - Views should be dumb, no logic, just presentation.
 - ViewModel contains presentation logic (notifies View on updates, etc.)
     Allows for:
     - Consistent behavior
     - Easy to reuse logic
     - Easy to test
 - Model is where domain logic is.
    Allows for:
        - Cohesion to other domain logic (don't store domain logic based on where presentation uses it)

Handle use cases as commands.

L: Interesting view on how MVVM is a driver adapter and ViewModel is calling application layer domain commands.

Some of the stuff is Swift related for iOS development, not really relevant.

Async Use Case Factory seems like a strange or at least very specific to Swift.
Split to Command and CommandHandler solves by reusing DI container.

Connectors, "fancy" DI container, that is also used for navigation, has all navigation links
View just says: onClick(connector.navigateTo(viewModel.getTarget()))


### Developing Your Developers by @h_carver
On learning:
ICAP: Interactive > Constructive > Active > Passive
The idea is that they are not neccessarilly better than the other, but matter based on context.
Example with playing saxophone and learning country flags.

Bloom's Taxonomy. Learning outcomes.
Know -> Understand -> Apply -> Analyse -> Evaluate -> Create
Model is missing "how" to get from one step to the other.

Model by the author/presenter: Knowledge, Skills and Wisdom.
 - Knowledge is something you can learn passively but can't necessarily apply it.
 - Skills is something you gain by doing and applying knowledge to achieve the satisfactory results.
 - Wisdom is something that allows you, given the holistic view of the context, to make insights and decisions that are better than others.


We try to convert wisdom into knowledge:
 - Rules of thumb / heuristics
 - Principles
 - Standards
 - Guidelines
 - Best practices

 But it is difficult to share wisdom, as it is contextual, decisions were made because of many contextual details.


### Application Modernization: Renovating a House While You Live In It
Ad for the company and using mainframe: "cheapest, fastest, most reliable"
 - Disruption to your business: how much time is needed for the process, what is return of investment?
 - Business risk: worst and best case scenarios of modernization?
 - specific drivers to modernize: 
 - Teams affected?
 - Business continuity plan

### Data Modeling in an Event Centric World
Ordered, immutable ordered listed with push back
Remove degrees of freedom, (I would say dependencies between components)
Create a one-directional pipeline instead.
Event sourcing: application decisions persisted and immutable event stream.
Turing machine analogy, tape is immutable list, service can read current status, or write new events to the tape.
Event schema is versioned separately from the service. It doesn't matter what the language the service is written in.
 - Fine grained streams
 - Sequential nubmering
 - Global ordering
 - Optimistic concurrecny
 - DB guarrantees
 - Positional queries
 - Push notification
 - Catchip subscriptions
 Stream per row, not stream per table.
Same id incremental over all tables results in incremental ids globally, in each table and on each row/object in temporal matter
Categories (could be a collection of tables in relational) are like aggregate roots
Temporal or history tables are given "by design".
Writes to event stream should be in 3rd normal form.
Ex. remove object event could contain just ID, and since ids are global, we are sure it will reference right entity.
Global id sequence also needed to know if you have all data from this stream, for cache invalidation, error checking, etc.
Cache alignment can be done just by comparing the latest id.
Ordered/quantum consistency as opposed to eventual consistency.
Optimistic locking based on global id, as a version. And locking is done on entity only, or category, but are not forced to table locks.
Distributed event bus, for communicating with external bounded contexts. Populated in 1st normal form through anti-corruption layer.
Components pushing out to distributed event bus have authority to say something is true so that others don't have to check it with your internal services.
! model process history, not current state
no flag fields, not nullable stuff


## Day 2

### Advantages and complexities of Event-Driven design
 - trasnactions help avoid parallel problems (ex. with age and payment)
    - two-phase commit is slow and complexities
    - two-phase commits are not supported in all DBs.
    - use sagas, transactions in phases, with undo/reverse transactions
 - [?] event driven systems are inherently parallel, that is not necessarily a plus of event driven systems, since simple REST/http servers can make parallel http calls as well.
 - SAGA has atomicity, consistency and durability, but not isolation (running transactions in parallel might not produce same result as running synchronuously).
    - basically isolation can be implemented on application logic, but is not "given"
In short: the "complexities of event-driven" design is that it is inherently parallel.

### Learn By Doing (It Wrong)
 - aiming for 100% test coverage doesn't mean you can turn of your rational thinking
    - example: if currentUser = loggedInUser -> editProfile else -> throw error
    - assignment operator vs compare operator
    - 100% test coverage: userCanEditTheirOwnAccount, notLoggedInUserCannotEditAccount
    - problem: logged in user can edit someone else's profile

 - The best code is obvious (paraphrased the principle of least astonishment)
 - I'll just deal with this later, Narrator: he didn't
 - You don't need backups untill you need them.

 ### Database-Per-Tenant Architecture using .NET
  - Single tenant architecture: each tenant has their own DB, instance of compute node and domain.
    + isolation, no noisy neighbour, easy individual backups and customization.
    - more to monitor, harder to mainain, more setup, scaling is enforced, price might move up too quickly with many tenants
  - Multitenant architecture: Single domain, single compute node (might be multiple instances for scaling), DB.
    ? How to ensure data is stored and acccessible only by the tenants?
        Tenants isolation, database schema, monitoring, isolation protection
        Scalability adding tenants, adding compute capacity.
        "Stuff that we need to think about"

    Tenants per DB, while single Compute node.
    shared-sharded: multiple db/multiple tenants
    Shared single DB: security layer, row level security
 - (Azure SQL Elastic pooling) Pay per pool, so having multiple db per tenant doesn't cost more.
 - Database-Level Firewall rules together with Server-Level rules
 - Elastic Database Tools - software for developing for elastic pool Azure DB.

### The state of the Art in Tackling Flaky Tests
 - Tests should be like fire alarms, if they go off, something is wrong.
 - Otherwise it's crying "wolf!" problem, people loose confidence in tests.
 - Somethimes falkiness of tests shows the problem in the software, not the tests.
 - correlation between memory usage and test flakiness.
 - Google reports, 1 in 7 tests a flaky, but only 1.5 % test runs are flaky, so majority of tests fail veeery rarely, and only small amount of tests fail frequently.
What to do:
 - Keep builds green
 - Measure flakiness
 - Escalate flakiness

 Some ignore flaky tests and still run them post-merge
 


