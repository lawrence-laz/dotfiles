
```csharp
public class await {}

public int Foo()
{
    await task; // <-- this is valid? await is not restricted keyword unless you use async? :D
}
```



--------

nullable is an afterthought, nullable type, nullable csproj setting, ref type nullable vs value type nullable, need to know type signature


-------
properties kinda suck
the pros are "cleaner looking code" and "encapsulation"
the code should not look clean, it should be readable in a sense that there is information encoded in the text you are reading.
when you see `myVector.Normalized` you don't know whether `Normalized` is a simple data access field, or a property which is
essentially a function with arbitrary logic, possibly firing events and invoking other logic, which can throw an exception
you can read it and understand without having to "know" 
things beforehand or having to navigate to definition to see what is what
sure it's a "bad practice" to throw in properties (insert sonar code), but since the language allows it, it happens
and the doors are left unlocked to such things, because "cleaned looking code" and "encapsulation"
this is not a place for this here, but that level of "micro" encapsulation would only make sense in public API,
which is consumed by external teams. if you are working in a closed module you should prefer cohesion over decoupling.

----
how many different ways to make thinks readonly? init, readonly, get; only

----
there's no error handling on language level
yeah there are exceptions, but these are basically "crashes" that usually get caught at the top-level and logged and the use case is terminated.
given code like this:
```cs
Foo();
Bar();
```
You can't be sure if Bar() will be reached at all times just by reading this code.
Foo might throw.
You could do `try { Foo(); } catch (Exception e) {}` but there is no way to know if that is necessary and if you want to be sure
you would have to use `Exception` to catch all exceptions, because if you targeted only some specific exception that you
*know* is possible when calling `Foo()`, like `IOException`, there is no way to know if Foo will not end up throwing something else.
the compiler will not check that you handled all possible error types.
So in case of errors and not "exceptions" you would have to either stick to `bool TryFoo()` convention and check if return is `true` `false`
or create custom error codes with error result type that would be returned `Error<T> Foo()`, but again, there is no language level support
if Foo() has two other function calls that can also return errors, you have to merge them manually and return form `Foo()`

----
events suck, no `async Task`, the `+=` is a footgun that you have to be careful about to not create dups, so what
happens in practice is `-=` and then `+=`. It's like a list of delegates but worse.
-----=
f
