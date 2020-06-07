# CE
> Collection of open-source GML libraries

![License](https://img.shields.io/github/license/slagtand-org/ce)
[![Discord](https://img.shields.io/discord/686494539308859394?label=Discord)](https://discord.gg/QjyxmHP)

# Table of Contents
* [About](#about)
* [Installation](#installation)
* [Documentation and help](#documentation-and-help)
* [Libraries](#libraries)
* [Links](#links)

# About
CE is a collection of open-source GML libraries for GameMaker Studio 2. Its target is to provide you with a strong codebase so you can focus on coding your games instead of their technical backgrounds.

Previously it was released only as a single extension [CE Core](https://github.com/kraifpatrik/ce-core), which suffered from dependency hell when trying to include only a specific library. This was the main motivation to split the extension into multiple repositories, each representing a library, which can be then included into you projects using [Catalyst](https://github.com/GameMakerHub/Catalyst), the open-source package manager for GameMaker Studio 2.

# Installation
Use [Catalyst](https://github.com/GameMakerHub/Catalyst) to add CE into your project.

*Adding the entire collection - all libraries listed below:*
```sh
catalyst require slagtand-org/ce@<release>  # e.g. slagtand-org/ce@1.4.0
```

*Adding a specific library:*
```sh
catalyst require slagtand-org/<library>  # e.g. slagtand-org/ce-class
```

When including a single library, Catalyst automatically resolves its dependencies and adds them to your project as well.

# Documentation and help
Documentation for the latest release of CE is available online at https://kraifpatrik.com/docs/ce. If you need any additional help, you can join its dedicated [Discord server](https://discord.gg/QjyxmHP) or its [forum thread](https://forum.yoyogames.com/index.php?threads/62585/).

## Building documentation
If you need a documentation for a previous release or you just want to have the documentation available offline, you can build it using [GMDoc](https://github.com/kraifpatrik/gmdoc).

**Example:**
```powershell
git clone https://github.com/slagtand-org/ce.git
cd .\ce
git checkout 1.4.0
catalyst install # Required to install the libraries included in the release!
gmdoc build
```

# Libraries
Following is a list of libraries which are included in CE in *this* commit. If you want to see libraries of a specific release, please checkout to its tag.

* [CE Array Utils 1.1.1](https://github.com/slagtand-org/ce-array-utils/tree/1.1.1)
* [CE Assert 1.0.0](https://github.com/slagtand-org/ce-assert/tree/1.0.0)
* [CE Callstack Utils 1.0.1](https://github.com/slagtand-org/ce-callstack-utils/tree/1.0.1)
* [CE Class 1.0.1](https://github.com/slagtand-org/ce-class/tree/1.0.1)
* [CE Color Utils 1.0.0](https://github.com/slagtand-org/ce-color-utils/tree/1.0.0)
* [CE Compare 1.0.0](https://github.com/slagtand-org/ce-compare/tree/1.0.0)
* [CE Component 1.0.1](https://github.com/slagtand-org/ce-component/tree/1.0.1)
* [CE Depth Sort Component 1.0.1](https://github.com/slagtand-org/ce-depth-sort-component/tree/1.0.1)
* [CE Draw Utils 1.0.1](https://github.com/slagtand-org/ce-draw-utils/tree/1.0.1)
* [CE DS Bucket 1.0.0](https://github.com/slagtand-org/ce-ds-bucket/tree/1.0.0)
* [CE DS Index 1.0.1](https://github.com/slagtand-org/ce-ds-index/tree/1.0.1)
* [CE Event Listener Component 1.0.0](https://github.com/slagtand-org/ce-event-listener-component/tree/1.0.0)
* [CE Event System 1.0.2](https://github.com/slagtand-org/ce-event-system/tree/1.0.2)
* [CE Hex 1.0.1](https://github.com/slagtand-org/ce-hex/tree/1.0.1)
* [CE Input 1.0.1](https://github.com/slagtand-org/ce-input/tree/1.0.1)
* [CE Iter 1.0.1](https://github.com/slagtand-org/ce-iter/tree/1.0.1)
* [CE List Utils 1.0.1](https://github.com/slagtand-org/ce-list-utils/tree/1.0.1)
* [CE Macro 1.0.1](https://github.com/slagtand-org/ce-macro/tree/1.0.1)
* [CE Map Utils 1.0.1](https://github.com/slagtand-org/ce-map-utils/tree/1.0.1)
* [CE Math Misc 1.0.1](https://github.com/slagtand-org/ce-math-misc/tree/1.0.1)
* [CE Matrix 1.0.1](https://github.com/slagtand-org/ce-matrix/tree/1.0.1)
* [CE Object Utils 1.0.0](https://github.com/slagtand-org/ce-object-utils/tree/1.0.0)
* [CE Quaternion 1.0.6](https://github.com/slagtand-org/ce-quaternion/tree/1.0.6)
* [CE Real Utils 1.0.1](https://github.com/slagtand-org/ce-real-utils/tree/1.0.1)
* [CE Scene Graph Component 1.0.0](https://github.com/slagtand-org/ce-scene-graph-component/tree/1.0.1)
* [CE Serialize 1.0.1](https://github.com/slagtand-org/ce-serialize/tree/1.0.1)
* [CE State Machine Component 1.1.0](https://github.com/slagtand-org/ce-state-machine-component/tree/1.1.0)
* [CE String Utils 1.0.1](https://github.com/slagtand-org/ce-string-utils/tree/1.0.1)
* [CE Surface Utils 1.0.1](https://github.com/slagtand-org/ce-surface-utils/tree/1.0.1)
* [CE Time 1.0.0](https://github.com/slagtand-org/ce-time/tree/1.0.0)
* [CE Timer Component 1.0.1](https://github.com/slagtand-org/ce-timer-component/tree/1.0.1)
* [CE Tween 1.0.0](https://github.com/slagtand-org/ce-tween/tree/1.0.1)
* [CE UUID 1.0.0](https://github.com/slagtand-org/ce-uuid/tree/1.0.0)
* [CE Vector 1.0.2](https://github.com/slagtand-org/ce-vector/tree/1.0.2)
* [CE Window Resize Tracker Component 1.0.2](https://github.com/slagtand-org/ce-window-resize-tracker-component/tree/1.0.2)
* [CE XML 1.0.1](https://github.com/slagtand-org/ce-xml/tree/1.0.1)

# Links
* [Public Trello board](https://trello.com/b/ZcvOyZwc/ce)
