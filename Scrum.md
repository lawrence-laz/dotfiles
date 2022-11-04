# Scrum

TODO:
- [ ] Who's taking up scrum master role? We used to not have any, but all members were very engaged and someone always picked up the ball
- [ ] Need clear backlog ordered by priority where items can be taken from the top
- [ ] Need burndown chart with sprints

Empiricism - knowledge comes from experience and making decisions based on what is observed
Lean thinking - reduce waste and focuse on the essentials
Iterative, incremental approach - optimize predictability and control risk

Transparency - to those performing and receiving the work, decisions are based on the perceived state, low transparency can lead to decisions that diminish value and increase risk.
Inspection - artifacts and the progress toward goals must be inspected frequently and diligently.
Adaption - any process deviates outside of the acceptable limits or if the resulting product is unacceptable, there must be an adjustment. The adjustment must be made as soon as possible to minimize further deviation.

## The Srum Team
Autonomous, cross-functional, responsible for all product-related activities

### Roles
Product owner - orders the work for a complex problem into a Product Backlog
    - Accountable for the Product Backlog
        - Create and communicate Product Backlog items
        - Order Product Backlog items
        - Ensure Product Backlog transparency, visibility

Scrum master - 
Developers - 
     - Create the Sprint backlog
     - Ensure quality by adhering to definition of done
     - Adapt the plan each day towards the sprint goal
     - Hold each other accountable as professionals
     - Size Product Backlog items

## Events
Sprint - all "wrapping event". By the means of sustainable pace improves team's focus and consistency.

Daily scrum (15min) - event for the Developers, structure is flexible, but goals are clear:
    inspect progress towrd the Spring goal
    actionable plan for the next day of work
    identify impediments
    adapt Sprint Backlog

Product Backlog Refinement - an ongoing activity of breaking down and further defining Product Backlog items into smaller more precise items, adding details, ordering and sizing them.

Sprint planning (8h for 1 month sprint) - initiates the Sprint, sole discretion of developers. defines:
    sprint goal - PO proposes, everyone collaborates to define
    sprint backlog - based on past performance, upcoming capacity and definition of done
    steps (smalled work items 1d~) - how the planned backlog items will be implemented.

Sprint review (3h for 1 mongth sprint) - plans ways to increase quality and effectiveness
    inspect last sprint for what went well, what was problematic
    identify most helpful changes to improve
    address improvements with actionable items, add to sprint backlog

## Artifacts
product goal - the long-term objective for the scrum team. they must fulfill (or abandon) one objective before taking on the next.

product backlog is an emergent, ordered list of what is needed to improve the product. it is the single source of work undertaken by the scrum team.

sprint backlog - real-time picture of the work that the developers plan to accomplish during the sprint in order to achieve the sprint goal. if the work turns out to be different than they expected, they collaborate with the product owner to negotiate the scope of the sprint backlog within the sprint without affecting the sprint goal.
    sprint goal (why?) - the sprint goal is the single objective for the sprint, which increases product value and utility. although the sprint goal is a commitment by the developers, it provides flexibility in terms of the exact work needed to achieve it.
    selected product backlog items (what?) - 
    actionable plan (how?) - work items tipically 1d length

increment - a concrete stepping stone toward the product goal. each increment is additive to all prior increments and thoroughly verified, ensuring that all increments work together. in order to provide value, the increment must be usable. the moment a product backlog item meets the definition of done, an increment is born.

definition of done - a formal description of the state of the increment when it meets the quality measures required for the product (shared among teams).

## End Note
> the scrum framework, as outlined herein, is immutable.
> while implementing only parts of scrum is possible, the result is not scrum. 
> scrum exists only in its entirety and functions well as a container for other techniques, methodologies, and practices.

## References
 - https://scrumguides.org/scrum-guide.html

--------------------------------------------------------------------------------
# Estimation

todo:
- [ ] update table to match user story points

## User Story Points
An abstract estimation unit that takes into account work item's:
 - complexity & effort required
 - time required
 - risk & uncertainty

## Input
User Stories presented by the Product Owner.

## Process
1. The Scrum Team refines, breaks down and adds details to User Stories
2. The Developers play Planning Poker to estimate User Stories in User Story Points

## Output
User Story points

## Planning Poker
1. The Developers individually choose an estimate value from the User Story Points Table and all reveal their choice at the same time
2. If smallest and biggest estimates differ a lot the Developers discuss why they think the item is bigger or smaller
    2.1. The estimation is then repeated
3. The estimate is averaged and rounded to the nearest value from the User Story Points Table
4. If the estimated value is too big to fit in a sprint, the item needs to be broken down into smaller ones and the Planning Poker starts again

## Calendar time
Calculation: estimated_duration = user_story_points / (velocity * capacity_ratio)
    estimated_duration -> duration in sprints required to complete a chosen amount of work items
    user_story_points -> sum of user story points for a chosen amount of work items
    velocity -> average amount of user story points the team completes in a single sprint
    capacity_ratio -> a value between 0 and 1 indicating team's capacity, this is mainly to account for developer day-offs

## Comparison to waterfall estimates
+ Realistically optimized (forecast adjusts with each iteration and is based on empiric data)
- Requires data(time) to start providing usable forecasts (team's velocity averages out during multiple sprints into a reasonable number)
