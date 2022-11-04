ecs
---

 - store components in arrays where index is entity identifier (what if there are too many entities?)
 - switch from arrays to dictionaries for lesser used components to save space at a cost of cpu?
 - system method receives just arrays, where some values can be null?
 - extension method with static overload to check that all values are not null, continue otherwise.
 - just a little bit of indirection, but int id could still be based on an incremental int.
 - components as structs under 16 bytes for very efficient copying
 - 