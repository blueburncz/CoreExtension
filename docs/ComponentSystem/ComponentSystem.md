# Component system
Since GameMaker Studio 2 does not have support for multiple inheritance, it can become problematic to share code between objects which do not or cannot inherit from a common ancestor. The component system tries to address just that. It allows you to write game logic in form of components, which are special [classes](./ClassSystem.html) consisting of data and scripts which are triggered in specific events. These components can be added to and removed from instances on runtime. An example of a component could be an AI component, which would normally be added to enemies, but could also be added to disconnected players in a multiplayer game. This section should help you get started with the component system more easily.

## Contents
* [Initialization and clean up](./ComponentSystemInitializationAndCleanUp.html)
* [Adding components](./ComponentSystemAddingComponents.html)
* [Executing components' logic](./ComponentSystemExecutingComponentsLogic.html)
* [Retrieving components](./ComponentSystemRetrievingComponents.html)
* [Removing components](./ComponentSystemRemovingComponents.html)
* [Creating custom components](./ComponentSystemCreatingCustomComponents.html)