
- Devblog
	- [ ] Code duplication is cheaper than bad abstraction, it's easy to extract duplication to abstraction, it's hard to refactor abstraction with changes.G



 - post on polymorphism, how it's not just for OOP, in fact procedural programming can have same polymorphism or more
 - encapulation and how it's mostly important on module level (https://www.youtube.com/watch?v=YpJufWdZFB8)
 - low coupling - high cohesion: the most important principle in complex software
 - fields are state, they mean you own something, if you don't own it but just depend it to carry out a specific function, add that to function parmaters
 - Write on the needs of coding standards: if you are writing software alone, you can write it however you want, because it only has to match your mental model and be understood by a computer. But when you are writing software withing a team it is no longer just a dump of your mental model and computer interpreted logic, it's a communication between different people. And for that we need common language, established terms, rules, same as with spoken and written language. You cannot just dump your memory and expect it to be loaded and interpreted by another human being without issues.
    
   - Comments using https://utteranc.es/
   - LIQUID
   - code is evil, write less code
   - banned-names: class manager, class processor, fn process(),


- the paradox of abstraction in greenfield software to make it extendable and maintainable
    - in greenfield you usually don't know much yet, however following "best practivces" you start applying various paradigms and design patterns. You can end with a very "nice" and "simple" solution, where it seemingly is easy to mainain, it's elegant, etc. etc.
    but since it's greenfield, you didn't have a good understanding of the domain, or the domain is still evolving
    and suddengly there is a change that breaks all your abstractions, and the tiniest change require reworking big parts of the system
    that is the paradox of abstractions that make "extendible" systems, the systems become less extendible
    instead make the sytem simple, no abstractions, but composable, where already solved parts can be easilly moved around and composed with other solutions
    aboid abstractions, depend on constractual data between usecases


- references and pointers suck, IDs rule
