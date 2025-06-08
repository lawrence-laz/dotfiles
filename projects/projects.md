# Projects

A collection of ideas on what to work on.

*For an actionable list of things to do go to [[todo]]*

Project is an effort spent in a limited duration to achieve a specific result.
Projects are just one way to spend [[my effort]].


->>> Some go with rust + go, maybe I shuld try Zig + Go based on context?
What about swift?

- Use google trends to find niche and something useful, then look for existing products, if they are there, it's a good sign, shows it's viable, now think about how you can make things better there and try to compete?

- [ ] compression based on function generators, just take random functions with random input and search for ranges where values match what you need
then join them up into a sequence until you get what you need.
it compresses as hard as possible depending on how much time you have
ideally it could compress to a single int if it finds the irrational number whose decimal places match your required bindary data.
expensive compression, cheap decompression, cheap size?


-TODO: reference tracker for sound and pictures, easy to naviagte, search, categorize, tage screenshots etc. Move into snipsnap? target artists?

In progress projects:
-------------------------------
- Playground figure out 3d transform tree
    - [ ] copy to local
 - Learning (Zig and shell?):
 	- https://adventofcode.com/2023/stats
	- https://v2.ocaml.org/learn/tutorials/99problems.html
	- https://github.com/codecrafters-io/build-your-own-x
	- https://github.com/codingonion/hello-algo-zig

- [ ] transfer raktai.net from go daddy to github pages?
- [ ] group like in folders in here as well


- Household
    - [[apartment]]
    - [[house]]
- Software
    - Desktop
        - [[snipsnap]]
        - [[keyboard]]
        - [[diffly]]
        - [[clipstack]]
    - Games
        - [[running-mmo]] (training?)
        - [[parawar]]
        - [[space-mmo]]
        simcity mmo
    - Libraries
        - [[jaysan]]
        - [[zig-enumerable]]
        - [[toolset-net]]
        - [[decor]]
        - [[pipeline-zig]]
        - [[csv-zig]]
        - [[zippy-term]]
    - Mobile
        - [[vegan-lt]]
        - [[focus-do]]
        - [[audio-drop]] 
        - [[daily-writer]]
        - [[wisdom-training-app]]
    - Tools
        - [[sqlite-terminal-studio]]
        - [[single-file-db.md]]
        - [[cli-repl]]
        - [[nvim-text-object-between]]
        - [[cli-convert]]
        - [[touchy]]
        - [[treesitter-lsp.nvim]]
    - Web
        - [[youtube]]
        - [[augalinis-maistas]]
        - [[devblog]]
        - [[generic-analytics]]
        - [[math-learner]]
        - [[po-pakuotes]] closed
        - raktai.net
- Writing
    - [[The Distance Between Us]]
    - [[the-human-way]]


sort out Random ideas below, like some are pretty good, ex. (code complexity analysis)


Basement:
--------------------------------
- cli name tester to see if it's a good name (check github with stars, brew repo, apt-get, arch repo, aliases of dotfiles, etc.)
- chew (probe?) -  cli tool for analysing data
	- !!!!!!!! something pretty/possibly cool -> wolphram alpha for data?
	- show many things according to data, offer transformation services, etc.
	- free for individuals and academia, paid for bigger companies and support
	- wolphram alpha kinda does this already: https://www.wolframalpha.com/examples/pro-features/file-upload
	- do I need this for CLI? would be cool, but probably not worth it
	- need better name?
	- portal and cli tool
	- stdin -> json, xml, csv
	- analyse and summarize metadata
	- analyse and sumarize contents
	- statistical analysis
	- do it in zig?
- http.nvim - handle *.http files to run requests in plain http format (use multiple back-ends, start with curl)
 - Scanner, give regex and it outputs scanned and parsed variables
 - Pipe method for providing delegates like middlewares
 - Tier rating (meme?) implementation for twitch, where watchers can suggest items, watchers can vote and suggest, host chooses, with renamable and changing tiers, auto color with ability to change color, pasting link to youtuve etc, makes a clickable box with name (renmaable) and image either from page or youtube thumbnail.
 - "Nice to have, too big" Racing game multiplatform online with rooms mario cart like and mugen like customizations
    - different modes
    - funny racing/fighting
 - Stream Buddy (host buddy?)
    - fun interaction for users to use channel points with, like black out, inverse rotate upside down, etc.
    - mini games
    - avatar
    - commands
    - lists
    - raffles
    - etc, view streams and see what people use
    - sell on steam/itch, etc.
    - show when speaking and muted
    - show when too loud/too silent
    - analyse multiple inputs/outputs
 - The Good Code - non-profit creaating software for people who need it
 - Life improving software that helps us humans be better
 	- gamify daily life
 - Poem lang. functional, cmd native (kinda bashy), but with type checks (like crystal, mostly inferred). Each poem program is called a poem and is contained in a `*.poem` file. Each poem is a function, a library and a cmd tool all at once. Piping and streaming is important. No colorful functions. Injection, algebraic effects.
RPG where people can create pixel art as crafting, gather pixels as resources and use it as currency.
   - Inspired by r/place
 
 - (bouncer) Middleware for filtering out bot requests for public apis.
 - "Graph programming language"
   - Nodes and connection to program.
   - As similar to how you would explain processes or other functionalities while drawing on whiteboard as possible.
   - Helper components to expand and collapse, etc.

Helper stuff:
---------------------------------
 - Name generator: https://www.imprima.com/reources/project-name-generator
 - Fun words: smoothie, fresh, juice 🍊, yummy, pop, spark, pine, windy, goblin, 
 - martian, hoodie, shades 🕶, void, bubbles 🫧, bubblegum!, polish, bones, helmet🪖, 
 - villain, plasma 🧛🩸, fairy🧚, genie, cowabunga! 🌊, steel, iron, flip, zen, gorilla, 
 - breath, brains, polar 🐻‍❄️, panda 🐼, spider 🕸, watermelon 🍉, coconut 🥥, hot 🌶, snack 🍙, 
 - lunar 🌙, shock ⚡, worker 🦺, ding🔔, plug🔌, reach 🪜, poseidon 🔱, trident, ouch🩹, sweep🧹,
 - juicebox 🧃
 - melt 🫠
 - playground 🛝
 - jelly, comb, moose, siren 🚨, speak-up 🎤

Random ideas
--------------------------------------
 - Codebase Complexity Analysis:
	Problem: Understanding the complexity of a codebase can be challenging, especially for large projects.
	Tool Idea: A command-line tool that analyzes codebase complexity, providing metrics, visualizations, and recommendations for simplification.
	Codebase Dependency Analysis:

	Problem: Managing dependencies between components within a codebase can be complex.
	Tool Idea: A command-line tool that analyzes and visualizes dependencies between modules, classes, or functions within a codebase.

 - Web Scraping Automation Tool:
	Problem: Automating web scraping tasks often involves complex scripts and tools.
	Tool Idea: A command-line tool that simplifies web scraping automation, allowing users to define scraping tasks and extract data efficiently.

- Web Content Change Notifier:
	Idea: A command-line tool that monitors specific web pages for changes and notifies users when content is updated. This could be useful for tracking changes in news articles, job postings, or other dynamic web content.

- Web Page Screenshot Generator:
	Idea: A command-line tool that takes URLs as input and generates screenshots of the corresponding web pages. This could be useful for creating visual documentation or monitoring changes in the visual appearance of web pages. 

- Directory Cleanup Assistant:
	Idea: A tool that scans a directory for unused or unnecessary files and provides options to delete or organize them. This could help users keep their project directories tidy.
	Unused File Finder:
	Idea: A tool that identifies and lists files in a project directory that haven't been accessed or modified within a specified timeframe. This could help users locate and remove unnecessary or outdated files.
	Duplicate File Remover:
	Idea: Create a command-line tool that scans a directory for duplicate files based on content and provides options to remove or consolidate duplicates. This can be useful for reclaiming storage space.
	System Cleanup Assistant:
	Idea: Create a tool that performs routine system cleanup tasks, such as clearing temporary files, emptying the trash, and optimizing disk space.

- File Type Converter:
	Idea: Develop a tool that converts files from one format to another. Users can specify the input and output formats, and the tool handles the conversion process.

- url shortener

- ffmpeg tui ffmpeg:
	Description: Multimedia framework to handle multimedia data.
	Potential Enhancement: An interactive UI for setting conversion options, selecting files, and monitoring the conversion process.

- Just general termina UI for any cli app to interactively build and run (multiple times if needed)
	parse man page for options, etc.

- sed/awk interactive:
	Description: Stream editor for filtering and transforming text.
	Potential Enhancement: An interactive UI for entering transformation patterns, selecting files, and viewing transformation results.

- image converter/resizer/watermarker

- temp email

Deprecated
------------------------------------

 - !!!CREATIVITY "Parawar"
   - Simulating magical medieval universe in a roguelike perspective.
   - Skip? Too big, I'll die sooner.
   - Rise from the ashes as instanced online duel/dungeon etc.?
   - D&D like sheet and UI?
   - text first, with structural images for more text
   - all map is a nested graph of graphs
   - not grids, etc
   - time where trains existed (dgrayman like) 
   - npc players can be part of your party
   - schedules for traveling with trains
   - teleportataion?
   - very heavy on audio (when someone says something, mumble sound, when a lot of people talking, crowd sound)
   - when something worthy happens, it plays a sound as well
   - not so much heavy on visuals, more on sound and text
   - It's D&D, it's mud, it's mmorpg. It's fun!
   - Use AI images?
 - GameDev:
    - Need to leverage my strengths: complex systems development, make stuff juicy (SOWRD1, Bakemono)
        - Action + RPG?
    - Online vs offline, while I have lots networking experience, it's still extra scope and maintenance.
        - Offline
    - Audience, don't want to be a niche, but something that could appeal to wide audience
        - GTA like free roam, do what you want with missions
    - Platforms, for max reach and reusability
        - All major: should be gamepad compatible
    - Iteratively and incrementally: look for feedback often, develop a fun toy and expand, clean up, repeat
    - Correct thoughts, but misguided efforts? Any games I make should be very simple and not require too much effort.

 - Game idea, which one is heavier/has more fat/more calories/older/bigger/taller etc. with levels
 - "Nice to have" Juicebox - c# declarative code first game engine.
    - the idea is that it should be dead simple, no technical/accidental complexity
    - good perfromance, not a compromise (ECS?)
    - usable defaults, effects, screenshake etc as first class citizens
    - groups for contolling multiple objects in one go
    - online multiplayer out of the box, just host "Server" somewhere
    - use it to make high quality and fidelity action games, with stuff like ropes, etc.
    - use it to make action-based ludum dare entries, 4:44 rule, 4 hours for mechanics, 44 for polish, simple, but enjoyable and challenging
    - High level, like you program in terms that are used to describe things
    - IMGUI for ui
    - good looking particle defaults
    - Too big






random from net
-----------
1. Courses (online prerecorded and webinars)

2. E-books (audio books)
	E-books provide an excellent opportunity to package and share your insights, expertise, and valuable knowledge in an engaging and effortless-to-read format.
	With e-books, you can create comprehensive guides that delve deep into specific topics, offering readers a valuable resource to enhance their understanding and skills.

3. Lists.
	Curating a list of valuable resources for others can be a easy and fast product you can build. From a list of essential tools for a specific industry to a compilation of the most inspiring and engaging tweets on Twitter/X, the possibilities are endless.
	By offering a carefully curated collection, you can provide a convenient and valuable resource that saves time and effort for your audience, while also positioning yourself as an expert in the field.

4. Templates (worksheets)
Create a simple yet powerful template on any app, such as Notion, to help others increase their productivity, organization, daily life, and business management.

This way, you will be able to save them multiple hours of work in exchange for the time and value you put into the template.

5. Memberships.
	Creating valuable resources that only community members can access is a great way to build a strong and engaged community.

	By offering exclusive content, such as in-depth tutorials, live webinars, or personalized consultations, you can provide ongoing value and support to your members, fostering a sense of belonging and loyalty.

	Regularly engaging with your community by answering their questions and addressing their needs further strengthens the relationship, making it a win-win situation for both you and your members.


6. SaaS.
	If you know how to code or are familiar with no-code apps, you can try to create software that solves one problem really well.

	This is by far the best digital product it could be, but it requires a lot of prior experience. So, if you're just starting out, don't waste too much time unless you already know how to code and market.

7. Printables
8. Digital planners
9. Workbooks with exercises
10. Podcast
11. Video games
12. Mobile apps
13. Desktop apps
14. Journaling template?
15. Checklist template
16. Browser plugin <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
17. Azure devops plugin?
18. Github plugin?





https://modestmitkus.notion.site/Digital-Product-Ideas-9c19ee8111e74118b3d33b4e58347a91
=================




