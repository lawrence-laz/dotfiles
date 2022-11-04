# Commander

A tool-belt framework for managing command line tools.

In case commands are code files, they should be automatically recompiled on change.

Csharp relies on `dotnet tool install -g dotnet-script`.

commands/
    know.cs         # file name is command name.
    search/         # can contain folders with main.* file inside.
        main.js     # supports multiple languages
