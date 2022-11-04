- [ ] Create a list of ideas for creating small tools/scripts to help with stuff
    - [ ] nvim extension [[nvim-text-object-between]]
    - [ ] fzf: cpf, mvf, findf, etc.
    - [ ] share gdscript 
    - [ ] init


Title: Zig Development Environment in Neovim: Speed Meets Simplicity
Thumbnail: ???
    - TODO: get screen key working (key cast?)

- hook intro
    - you can pretty much see the entirety of it here

- hi 

REDACTED V2:
- So you know how often times it's quite difficult to tell, which is more effective: solving an issue at hand, or building a utility, which helps you to solve the said issue now and in the future.
Development environment is one of those scenarios where I spare no effort and really want to get things right,
since it's a piece of software that I use daily.
- Admittedly it took a while to get the setup that is "just right", but I have been using it for quite a while know and I really enjoy it, so I wanted to share it with you, hoping that you'll find it to be quite cool as well, and mayyybe even take something out of it to include into your own workflow.

- so my workflow can be decomposed into 6 different components:
1. session managment
2. file management
3. code editing
4. automated testing
5. code debugging
6. version control

let's start with the first one
*roll title animation with music*

    - I develop on a laptop so I prefer most things I can do with keybaord as opposed to touchpad and quick
    switching between screens/windows/workspaces
    - and just in case you're wondering I don't normally run camera as a background I jus tthought it looks kinda cool for the video lol

    - so for session managment I use tmux, 
        - I can open new sessions with fzf by <leader>f

        - I can switch between sessions in session list view, or just jump between last sessions using <leader>L
        - I normally have quite a few sessions running, 
        - like dotfiles, some git repos for reference, like zig-sdk, the project i am working on, notes session, etc.
        -but you can use search in the seesion search screen so it's not an issue to find the one you need

    - for code editting I use neovim
    - lets open it up in git folder
    - you can see all the files in the folder for this I use oil.nvim
        - it allows you to naviage the file sytem and modify it as if its a file
        - you can create multiple files by just writing file names in new lines
        - when saving a file the editor asks if you want to perform file operations
        - to delete you just delete the lines
        - you can also copy/paste between (show this quickly)

        - lets create a directory for of showcase project

        - I will initialize a zig test project open up the main file
            - init zig-test
                - [ ] use init, but don't advertise, just create a project that way to demonstrate test vs exec

        - so we can immediatelly see syntax highting provided by treesitter
            - treesitter understands code syntax, which provides not only highlighting,
             - folding
             - but enabled shortcuts to edit code objects, like the one I use the most is to change an argument in a function I can do `cia`, or to select do `via`, pressing `a` further moves on to the next argument


        - so I'm not one of those who code without any LSPs, that is no code completions, go to definions, jump to usages, etc. 

        - for this you'd use zls, a language server for zig created by the community, this enableds IDE like features:
            - code completions
            - diagnostics
                - [ ] view errors, go to error
            - go to defintions
                - this is especially good for zig, as zig standard libarary code is very readable and can often be consulted instead of doucmentation
            - jump to usages, etc.
            - this one I use quite a lot as well: so standard up down keys in vim are 'j' and 'k', if I press ctrl+shift I can jump between usages, this is something I use a lot, I guess you could just type * and go about using search, although that might include some stuff that aren't really reference, like words in comments.

        - idk, i might try going LSPless some time in the future

## Formatting:
    - another important part of the editor is formatting, unless you're ok with your code looking like it was just
    - you might have already noticed, that the file gets automatically formatted
    - luckily, zig comes with a prebuilt auto formatter, which can be simply configured to run automatically on file save.
    - this is provided by `zig fmt` command, which has opinionated formatting without any configurations, I have it hooked to be executed on file save and it's so nice, you no longer have to think about formatting code and can focus on important bits of actually solving the problems



## Tests
- there are mulitple ways to do testing, the most obvious one just run the zig command to run all the tests for you
- this can be done by openning a new terminal pane/window?
    - [ ] tmux pane
        - [ ] jumping between nvim and tmux
        - [ ] just <leader>l to jumb between two
        - [ ] <leader>g to go to error from tmux pane
    - [ ] but can do it in editor as well: running tests (test: run nearest, or just keyboard)
        - [ ] from summary
        - [ ] from shortcut on test
        - [ ] test error inline code
        - [ ] running a single test
        - [ ] viewing test output
        - [ ] viewing test run duration
    - [ ] debugging tests
        - [ ] breakpoints, conditional break bpoints
        - [ ] inspect stuff
        - [ ] callstack
        - [ ] repl?
    - [ ] jumping to errors in code (gF)

    - [ ] do some task, like small advent of code or something?
    - [ ] edit video (can be done later)
        - [ ] find free music and sounds
        - [ ] make a cool thumbnail that stands out from other similar videos
    - [ ] lazygit, not really anything related to zig, but end with a commit 
        - edit file

- neovim neotest-zig
    - [ ] showcase
    - [ ] postmortem (what was faced, how is it made, etc.)
        - [ ] the basic architectural overview of input and results file, output files, etc.
            - [ ] how neotest works (with build spec, run, reuslts, etc.)
            - [ ] how zig build test works cia CLI
        - [ ] running `zig build test` which includes multiple test steps (lib and exec)
        - [ ] all combinations of `zig test` and `zig build test`
        - [ ] lack of `--test-runner` in `zig build test` 
        - [ ] openning links from output via gF
        - [ ] single click in neotest triggers zig build test which then fires multiple test runs in parallel (if configured so in build.zig) and then each outputs their results, which then are aggregated and reported back to neotest


- [ ] neovimtree
    - [ ] hack to move files between instances
- [ ] oil.nvim
    Hacking NeoVim series?
    - [ ] hack to move files between instances


- [ ] neovim keymaps
    - [ ] yank append!!!

- [ ] command line remap with history and vim like editing
    - [ ] do you know about <c-f> in ":", or the short hand q:? Many people don't
    - it's a very useful way to edit commands and feels very natural
    - here's how to make it default (there are plugins, but if defaults work for you, here's how to configure them)


- [ ] why I like zig
    - crossplatform
    - comptime (very open to programming what you need without macros, instead of relying what is provided by the compiler/lang like generics)
        - ex generics can be not only types, it can be any value
    - very nice type system checking and compiler, anytype is still compile safe, unlike dynamic in other languages, which is runtime
    - open, does not belong to a company (there is organization though, but it's wonderfully ran by Andrew Kelley)
    - [ ] zig fmt no config, just one way to format code
    - [ ] no interfaces !? turns out you don't need to abstract everything under an interface



 	- How `fzf` can enhance your cli experience (cpf, mvf, findf, lsf, tmux fzf, pidf, whichf)
        think of more cool combinations with qr code, etc?
	- gdrive upload toos "share-file.sh"
	- why I like zig
	- zig-enumerable video, see readme in repo for ideas, maybe transfer them here, later on


- C# is good, but...
    - lack of optionals (half-assed) nullable type for ref vs value, one is compile time, other is runtime
        - ref nullable is slapped on.
        - compiler isn't very good at figuring out nullabilities, you have to hold hand and provide meta attributes
    - record struct
    - all types of fields/properties, set, private set, init, no set
    - reft struct, scoped, etc.
    - attributes, limited params
    - no inference on generics constraints
    - default parameters vs overloads, do you know which one gets called? build order matters
        - slap on extension methods and who knows what is going on
    - vsdbg is licensed not to be used outside of vs or vscode-Dtest-runner, open source samsung gives error on reflection repl
    - configureawait, configureawait configureawait (in context where thread context matters)
    - open generics require separate syntax
    - ne error assurance, anything can throw whatever
        - wrapped exceptions from different async contexts
    - colordness issues in sync code, of which there's quite a lot: properties, events, are historically non async
        - task vs value task
        - async non async when task is single return
        - task.fromvalue, task.completed
    - fragmented common attributes, ex. ignore a property in system.text.json, in Argon if you use verify, in serilog.
    - you either know a type or it's wild west, dynamic and object are 
    - events? how are they any better than a list of delegates? you cannot iterate normally, is order guaranteed? if no subscribers, it throws...
    - enums are weak, cannot hold different values (Discriminated Unions)
    - generic constraints are limited, you can ask for a constructor, but not for specific parameters
    - the only way to stop structs from boxing when passing as interface is to use generics constrained by interface?
    - compare interfaces, cannot be inlined implementation in some apis
    - lambda captures are weird sometimes? for i takes ref to i, even though i is a value type? this could be ref vs value
        - also ref keyword, out keyword, it very much didn't want to have pointers to be "simple" but then it has all these other things.
        - with unsafe there are pointers though
    - everything is an object
    - opaque framework behavior, like some things need to be properties, they might neet a setter, or a getter, they might need to be public, or not.
    - list is covariant, array is not? https://learn.microsoft.com/en-us/archive/blogs/ericlippert/covariance-and-contravariance-in-c-part-two-array-covariance
        - string[] stringArray = new string[] { "1", "2", "3" };
            object[] objArray = stringArray; //no compile time error, no type safety!
            objArray[0] = new object(); //Runtime exception!;

            Animal[] animals = new Goldfish[10];
            animals[0] = new Tiger();
        - List<string> stringList = new List<string>() { "1", "2", "3" };
            List<object> objList = stringList; //compile-time error
            objList[0] = new object(); //Can't even get here because it won't compile in the first place.
    - esxpressions support types for `is` but `is not` does not work?
    - there's so much variants of syntax, `=>` is in methods expressions, in lambda, in properties, but it means different things.
    - IEquatable<MyStruct>, IComparable<MyStruct>, IComparable
    - `void` doesn't have a value, requires extra methods or return `Unit.Value` made up structs. Each library have their own ofcourse.
    -Dispose vs DisposeAsync




some things, which are pretty good:
    - linq expressions, the iterator lib but not only that, it creates a syntax tree that can be used as data/tramsformed to sql, etc.
    - pattern matching, switches and ifs






 - dev courses


 - ziglings
 - 99 problems
 - perf ninja
 - https://github.com/zigcc/zig-cookbook
