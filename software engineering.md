# software engineering

    move loops into functions and conditions out to callsites

ECS:
    - tag component without state
    - use utility functions to share logic between systems, acts on multiple components to carry out a use case
    - deferments mutate stuff later, in one place when possible (queue components)
        - entity lifetime, you create ulid in the middle, so other systems can refer to them, but the entity will be created at the end
            - entity could be queried by others from a separate buffer list, which will be merged with main at the end of the loop
    - singleton components, don't couple system to system, have state as singleton component, it might be used somewhere else as well
    - double-buffer state, where you read one and modify another? maybe just defered queues, are simpler?
    - budget in time (like 1.5ms) for executing a system, stores state and continues next tick
    

many callsites: read little data surface (not amount), little to none mutations, 
few callsites, read more surface, big mutations
in other words, try to keep major mutations in a single place
    - aids resolving stuff (like possible conflicts) in a single place.
    - buffer, manage performance impact, batch, etc.


when possible, defer side effects for later, ideally at the end

DHH: progress is our path, complexity builds a bridge, simplicity waits
i. e. complexity is necesary for progress, but it's not where progress stops, you don't stop when you solve the
problem in a complex way, you stop when you make the solution simple

setup ssh pub key, set up as only auth method, ufw allow OpenSSH, ufw default deny incoming, ufw enable

meritocracy vs democracy - people who put in the work and contribue most are the ones who get to have the say
and set direction. as opposed to everyone is "equal" bus just bikeshed to cripple.
opinion of those who do the work is more important than others.

opensource is gift giving, not communities or democracies. either take the gift and be grateful or walk away.

follow what feels good to you, you don't have to use languages/frameworks/libraries that are "best"
use what feels best to you and makes you work and gives consistency and happines and as a result - results.
pursue excitment in competence and learning

when you hit an issue that is hard to fix, don't fix the issue, make it easier to fix first


Architecture's goal is to minimize the impact of decisions we make today on the future evolution of the system.

"Oftentimes the best design cannot be created without building it first. 
Otherwise you need to be clairvoyant, I am not, I don't believe anyone actually is. " - Prime?

"Before you make something re-usable, you need to make it useable" - Someone

All or nothing is not productive, focus on 20/80 principle, and put extra effort where needed and when needed. - LL

Bikeshedding - scrutinizing solutions to easy problems because everyone has their opinion/preference/something to say.
While difficult problems don't necesarilly invoke such heated discussions because people assume whoever is doing it
have thought it through. (I believe there is also less impulse to discuss diffiucult things)
It's unproductive, easy stuff can be solved in whatever way that is sensible enough and move on.
Focus on difficult problems.

LL: Using abstractions to separate core (high-level) from implementation (low-level) is a wrong way to go:
	> it seems like it no longer depends on implementation, because it depends on an "interface" or an "abstract class"
	  that's what dependency inversion principle tells us, right?
	  "high-level modules should not depend on low-level modules, both should depend on abstractions"
	  there's a BIG caveat though - there's still a dependency! you depend on an abstraction
	  it doesn't seem like a problem at first, and it might never become a problem
	  but it also very likely can become a problem, when the implementation/core/features/your understanding
	  of the problem space changes in a way that no longer "fits" the original abstraction 
	  and now you have to change it and suddenly everything changes.
	  you might say, that abstraction should not often change, right? but who controls that?
	  how likely are you to model the solution in a way, that it not only fits the current problem, all possible
	  future problems?
	  Or simply ask yourself: have you ever had to make a seemingly "simple" change in an otherwise elegantly designed
	  and seemingly flexible system, but then you find yourself having to modify multitude of files, and when you finally
	  get the thing to compile and act somewhat as expected you run the tests and see that they don't compile?
	  part of the existing tests mock things that no longer exist
	  I know I have.
	  The solution is simple, but not easy. Have better desing: don't depend on abstractions, instead depend on the thing
	  that changes even more infrequently than abstraction and that ever more closely represents the problem space:
	  DATA.
	  Define you high-level logic in pure data. Even operations if they have complex meta logic or orthogonal logic.
	  If you depend on something, just define the dependency as data, exactly what you need. Let the caller figure
	  out how to get that. This way your program flow can change, things can be created/destroyed/updated at different
	  places, different times. But the parts that depend on something only change when the actual data they depend on
	  changes.
	  Suddenly you find that you no longer need to mock your tests. Instead you just create test data objects and
	  pass those around.

My peronsal software engineering method:
- I NEED an envrionemnt where it's ok to make mistakes
- iterative and incremental is the way I design 
    - you ain't gonna need it
    - don't make decisions too soon, if you don't have to
    - don't paint yourself into a corner though
    - low coupling, high cohesion
- iterative and incremental development is the way I work (no waterfall)
- planning everything up front does not work, plan enough to get started
    - it's faster to iterate and build based on need, than to "predict" and then tear down or try to "fit" the solution.
    - Prime said it nicely:
        - do it 3 times (three iterations) for a nearly perfect thing
        - do it 2 times for production quality
        - 1 is just d**** out for Harambe (fast solution that makes it work, but not shippable, just a way to understand the problem and what is needed from a solution)
- embrace refactoring constantly
- design has to be refactoring friendly (low coupling, high cohesion)
- tests have to be refactoring friendly (black box integration tests > white box unit tests)
- do it well or don't do it all (unless it's a throw away prototype)
- I cannot multitask, let's do one thing at a time

Hills I am willing to die on:
- Composition is better than aggregation (composition over inheritance)

If you don't agree with some of these, that's fine, maybe you are looking for someone different.


 - YAGNI - predictive design does not work, design for now.
    - build on empiric data
    - we have this voice "what if", avoid giving in to it, solve problems for now
    - one thing worth doing is avoiding closing doors
    - decision means making a choice and cutting other branches off
    - delay decision as much as possible, solve problem in a simple way and adjust
    - https://youtu.be/OtozASk68Os?t=2341


[[cache]]

[[naming]]

:LIQUID
Local
Intuitive
Quintessential?
Ubiquitous
I
D

[[readme driven development]]

If reading code more questions are raised than answered, then something is wrong with the code.

[[automated testing]]

[[programming-languages]]

Architecture's goal is to minimize the impact of decisions we make today on the future evolution of the system. 


# Inheritence is dangerous: the hidden multiple concerns, or inheritence is NOT decoupling
it sometimes might feel like decoupling, but it is very much coupling only to reduce duplication

units should have boundaries where internals are of a single concept
violations of this are much more easy to notice in composition than in inheritence.
this is because in composition a component clearly contains two different concepts in a single unit
in inheritence the two different concepts might be separated by inheritence, where one concept is in parent,
the other is in child, example:
JpegImage -> Image, PngImage -> Image, BmpImage -> Image
This looks kind of ok, but Image is about representing visual image data, that you could draw on screen, regardless of how it is saved in the file system.
The child class has logic on how the said image is saved to file system (metadata, compression, etc.)

It looks like we separated the two concepts, but we didn't, inheritence IS AGGREGATION, the two classes ARE A SINGLE UNIT.

A good example on demonstrating this is ImageDraw logic, where you can draw the visual on screen. With class hierarchy like that you have to provide a JpegImage or PngImage to draw it, but what if it is not loaded from file system, what if you just have it memory? The encoding/compression/etc. stuff that comes with Jpeg is now traveling together everywhere.

Instead if you avoided inheritence, this situation would have been:
JpegImage, PngImage, BmpImage, where visual concept ofthe image is duplicated and very clearly is a separate concern.
You can then extract it as a separate unit and compose these together, where we have:
Image,
JpegImage --(field to)-> Image object,
etc.

Now these two things are clearly separate, the JpegImage doesn't even have to have a field of Image, the relation could be on function level for parameters/return types of load/save functions.

Now ImageDraw logic can refer to the visual concept Image without any hints or traces of Jpegs, Bmps, etc.


## Context of SCA
 - A complex domain of laser fabrication with many rules and functionalities, ranging from mathematics, physics to low level hardware control.
 - Many types of machinery each with multiple versions provided by various vendors.
 - Core software in a research & development context with an aim to aid in field advancments.

## Technical Principles
 - **Low coupling**: fewer dependencies between modules are better.
 - **High cohesion**: fundamentally similar components are located close to each other.
 - **Single responsibility**: modules have a single purpose to simplify maintenance and reduce inter-feature coupling.
 - **Dependency inversion**: high level domain logic should not depend on implementation details, both should depend on abstractions.
 - **Principle of least astonishment**: prefer common software engineering practices and avoid solutions that surprise (not in a good way).
 - **No undefined behavior**: It's better to see an error than not seeing one while it is hiding behind the scenes and causing unexpected problems.
 - **Well defined design**: software modules are described, together with their purpose, contracts, dependencies, states and lifetimes.
 - **Support confidence in change**: with a well designed system it should not be scary to make changes or introduce new functionalities. This might include solutions for versioning, migrations, etc.

"Build safety nets, not guard rails", on unit tests, on process on responding to errors/bugs, etc.
"tribal knowledge"
"throwaway solutions help move faster than rigid unit tested solution" - for start
Like shifting gears in a car.
----
Separating hardware concerns into three parts: device connection management, configuration management and enabling SCA with hardware features.
Separating common abstract concepts of hardware formulated in real world terms from their specific implementations tied to specific vendors.
Ports and adapters
Also known as hexagonal, this architecture provides structure and terminology to describe a system that has an abstraction layer between its domain logic and implementation details. Following the dependency inversion principle, functionality needed by the domain logic is provided as ports, which are domain layer abstractions. The specific implementations of these ports are called adapters and reside outside of the domain logic.

Linux inspired
A couple of concepts are borrowed from the Linux kernel, namely separation between userspace and systemspace API and handling of devices via connection buses and drivers.

Userspace API is the intended way to interact with Linux and is kept stable. Systemspace API is the internal part of Linux, which while can be accessed from the outside, does not guarantee any stability and can be changed at any time. This allows for the system to be flexible and accepting of refactorings, while maintaining a stable interface for most consumers.

Connection buses handle specific types of connections like COMPORT, ethernet, USB, etc. This includes tracking of the devices connected and assigning correct drivers for each device. In our case, the related low level functionality is already handled by the operating system, but on application layer the hardware module should be aware of the currently connected devices, provide a way to manage them, and assign correct internal SCA "drivers" that know how to perform SCA specific functions on each device.

On ports and adapters: one of the most common probably driver adapters is integration tests. These could run your application layer directly if design is good
