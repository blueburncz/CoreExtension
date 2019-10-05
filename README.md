# CE
> Collection of open-source GML libraries

![License](https://img.shields.io/github/license/kraifpatrik/ce)

# Table of Contents
* [About](#about)
* [Installation](#installation)
* [Libraries](#libraries)
* [Links](#links)

# About
CE is a collection of open-source GML libraries for GameMaker Studio 2 developed by an experienced programmer ([tools and graphics programmer of BBP](https://blueburn.cz/index.php?menu=bbp), [TyuTyu NyuNyu: The Forest Ninja](https://play.google.com/store/apps/details?id=com.blueburn.ForestNinja), [PushEd](https://github.com/GameMakerDiscord/PushEd), [BlueBurn AssetCreator](https://forum.yoyogames.com/index.php?threads/60628/), [Xpanda](https://github.com/GameMakerDiscord/Xpanda), [YYC Overwrite](https://github.com/kraifpatrik/yyc-overwrite), [Optimizing code for YYC](https://forum.yoyogames.com/index.php?threads/62937/)
, [Custom C++ in YYC without DLLs](https://forum.yoyogames.com/index.php?threads/63045)). Its target is to provide you with a strong codebase so you can focus on coding your games instead of their technical backgrounds.

Previously it was released as a single extension called [CE Core](https://github.com/kraifpatrik/ce-core), which suffered from dependency hell when trying to include only a specific library. This was the main motivation to split the extension into multiple repositories, each representing a library, which can be then included into you projects using [Catalyst](https://github.com/GameMakerHub/Catalyst), the open-source package manager for GameMaker Studio 2.

# Installation
Use [Catalyst](https://github.com/GameMakerHub/Catalyst) to add CE into your project.

*Adding the entire collection - all libraries listed below:*
```sh
catalyst require kraifpatrik/ce@<release>  # e.g. kraifpatrik/ce@1.3.1
```

*Adding a specific library:*
```sh
catalyst require kraifpatrik/<library>  # e.g. kraifpatrik/ce-class
```

When including a single library, Catalyst automatically resolves its dependencies and adds them to you project as well.

# Libraries
* [ce-array-utils](https://github.com/kraifpatrik/ce-array-utils)
* [ce-assert](https://github.com/kraifpatrik/ce-assert)
* [ce-callstack-utils](https://github.com/kraifpatrik/ce-callstack-utils)
* [ce-class](https://github.com/kraifpatrik/ce-class)
* [ce-color-utils](https://github.com/kraifpatrik/ce-color-utils)
* [ce-compare](https://github.com/kraifpatrik/ce-compare)
* [ce-component](https://github.com/kraifpatrik/ce-component)
* [ce-depth-sort-component](https://github.com/kraifpatrik/ce-depth-sort-component)
* [ce-draw-utils](https://github.com/kraifpatrik/ce-draw-utils)
* [ce-ds-index](https://github.com/kraifpatrik/ce-ds-index)
* [ce-event-system](https://github.com/kraifpatrik/ce-event-system)
* [ce-hex](https://github.com/kraifpatrik/ce-hex)
* [ce-input](https://github.com/kraifpatrik/ce-input)
* [ce-iter](https://github.com/kraifpatrik/ce-iter)
* [ce-list-utils](https://github.com/kraifpatrik/ce-list-utils)
* [ce-macro](https://github.com/kraifpatrik/ce-macro)
* [ce-map-utils](https://github.com/kraifpatrik/ce-map-utils)
* [ce-math-misc](https://github.com/kraifpatrik/ce-math-misc)
* [ce-matrix](https://github.com/kraifpatrik/ce-matrix)
* [ce-object-utils](https://github.com/kraifpatrik/ce-object-utils)
* [ce-quaternion](https://github.com/kraifpatrik/ce-quaternion)
* [ce-real-utils](https://github.com/kraifpatrik/ce-real-utils)
* [ce-serialize](https://github.com/kraifpatrik/ce-serialize)
* [ce-state-machine-component](https://github.com/kraifpatrik/ce-state-machine-component)
* [ce-string-utils](https://github.com/kraifpatrik/ce-string-utils)
* [ce-surface-utils](https://github.com/kraifpatrik/ce-surface-utils)
* [ce-time](https://github.com/kraifpatrik/ce-time)
* [ce-timer-component](https://github.com/kraifpatrik/ce-timer-component)
* [ce-uuid](https://github.com/kraifpatrik/ce-uuid)
* [ce-vector](https://github.com/kraifpatrik/ce-vector)
* [ce-xml](https://github.com/kraifpatrik/ce-xml)

# Links
* [Documentation](https://kraifpatrik.com/docs/ce)
* [Latest changelog](https://kraifpatrik.com/docs/ce/ChangelogLatest.html)
* [Forum](https://forum.yoyogames.com/index.php?threads/62585/)
* [Discord](https://discord.gg/nt5hZWt)
* [Twitch](https://www.twitch.tv/kraifpatrik)
