# software design patterns


notes: implementation details should not affect how client declares their desires (coomands/request, etc.)


A general, reusable solution to a commonly occurring problem within a given context.

 - [[specification pattern]]
 - [[command design pattern]]
 - [[bridge design pattern]]
 - [[memento design pattern]]
 - [[composites design pattern]]
 - [[builder design pattern]]
 - [[adapter design pattern]]
 - [[null object design pattern]]
 - [[facade design pattern]]
 - [[flyweight design pattern]]
 - [[prototype design pattern]]
 - [[visitor design pattern]]

Why?
    - avoid reinventing a wheel
    - improve communication (requires common understanding od definitions)
    - deliver better software (elegant solutions)

ℹ️ Note: patterns do not provide exact implementations. Depending on context you might see or make some variations. Just keep in mind that these variations have pros and cons.

ℹ️ It's not unusual for design patterns to look very similar in implementation point of view. But usually they differ in intent. Ex. [[bridge design pattern]] and [[strategy pattern]].

Initially patterns were introduces in the context of city building and architecture.
"A Pattern Language" is a book identifying the concept of design patterns:
    - how they should be described
      - Name and classification
      - Intent, what it solves
      - Also known as (people call things differently)
      - Motivation, scenario
      - Applicability or context where this works
      - Structure (diagrams)
      - Participants and their roles in pattern
      - Collaboration between Participants
      - Trade-offs
      - Implementation
      - Samples
      - Known uses
      - Related patterns, share structure or work well together.
    - organized by characteristics
    - provide a catalog of patterns.

"Design Patterns" Elements of reusable object-oriented software, aka hang of four book:
    - Established language for describing patterns
    - Organize by type:
      - creational, structural, behavioural.

Apply patterns in sandbox fist, compare and get the feeling of what it solves.

