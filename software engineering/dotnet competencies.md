# Software Engineer Competencies (dotnet)
4 items?


 - Dependency Injection (5 number of types moved to DI container in SCA)
 - Background Workder (remove existing background threads & Tasks)
 - Dependency inversion (Remove circular dependencies)
 - Solution & project structure (migrate to SDK-style csproj)

Dependency injection (Microsoft.Extensions.DependencyInjection)
    Lifetime management (singleton, transient, scoped)
    Scope management (IServiceScope)
    Service locator (anti)pattern
    Factories (Func vs typed)
    Single instance as multiple services registration
    Automatic registration (Scrutor)
    Parameterizing and injecting dependencies at the same time (ActivatorUtilities)
    Injecting specific implementation to specific type
    Optional dependencies
    Open generics
In-process messaging
    Command query separation
    Commands vs events
    MediatR
Solution & project structure
    Clean architecture (application, domain, infrastructure)
    SDK style .csproj
    Project/package references and transient dependencies
Multithreaded programming
    Async/await
    Tasks and cancelation tokens
    Locking mechanisms
    Concurrent collections
    Atomic operations
Declarative programming
    LINQ
    Pattern matching
Git
Automated testing (xUnit, Moq, Auto Fixture, Fluent Assertions)
Configuration
    Microsoft.Extensions.Configuration.Json
    Environment variables
    Options pattern
Serialization/deserialization
Exception handling
    Nested exceptions
    Blocking calls to Tasks
    Dynamic type invocation
    Call stack preservation
Caching
    Microsoft.Extensions.Chaching.Memory
Logging
    Microsoft.Extensions.Logging
    Serilog
Databases
    SQLite
Design patterns
    Strategy/Method template
    Factories
    Fluent builder
    Command
    Adapter
    Visitor
Principles and concepts:
    Single responsibility
    Dependency inversion
    Interface segregation
    YAGNI
    DRY
    Low coupling, high cohesion
    Ubiquitous language
    Separation of concerns
    Encapsulation
    Explicit dependencies
    Persistence ignorance
    Bounded contexts
    Polymorhphism (classic type based, method trader, etc.)
Background jobs (BackgroundService)
Hostservice
Lazy evaluation (enumerables, Lazy class, dependency injection)
Reflection
C#
    Value types
    Reference types
    Covariance, contravariance
    Generic constraints
    Immutability & records
    Lambda functions
    Null safety
Data structures
    Array
    List
    Stack
    Queue
    Dictionary
Algorithms
    Hash
    Binary search
GUI
    Windowns Forms
        Responsive elements
        Databinding
    MVVM
    Some other framework (WPF, Avalonia, Uno)
    OpenGL
Other packages
    CliWrap - running command line sub processes
    Polly - policy based resilience (retrying, circuit breaking, timeouts, etc.)
    Fluent validation - strongly typed validation rules
    BenchmarkDotNet - performance measurement
    Automapper - object mapping






