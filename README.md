# DemoInteroperability
A sample app demonstrating Objective C and Swift interoperability. Written in MVVM design pattern.

The project covers following asks from the given task:

* Used MVVM design pattern.
* Module 1 - vehicle list module is written in Swift and Module 2 - vehicle map module is written in Objective C and both are interoperable.
* The app downloads the list of vehicles from given web service.
* Displays the vehicles in a scrollable list and in map.
* Have written basic unit tests.
* The app calculates the distance of each vehicle coordinates from Hamburg coordinates and shows the vehicle list sorted based on this distance.

Following are other aspects of the project:

* Have designed a highly scalable, maintanable and generic networking layer. For implementing vehicle list API, I have written Requests > VehiclesAPI API which internally uses components from generic networking layer. For any further APIs required, we can write respective API in Requests > NewAPI. 
* For vehicle list module, have segregated dataSource also from VC. 
* Have kept minimum possible code in VCs and kept business logic separate from VCs.
* Considered Hamburg location (53.5511 and 9.9937) as reference location and many operations (showing vehicle distance and showing the vehicle in map from vehicle module) are wrt this Hamburg location.
* Have used structs and sub structs for storing constant values
* Have used all Swift advanced features like Protocols, Extensions, Structs and Generics whenever possible. Although could not make extensive use of these Swift specific features in order to maintain Objective C compatibility.
* Most of the basic classes (e.g. Utilities etc) are written in Swift so many @objc flags can be found to maintain the Objective C compatibility.
* Use of functional programming concepts (use of declarative function filter, reduce, map etc)
* Have used protocol oriented approach wherever possible. Have used protocols AlertShowable and Progressable
* While writing this app, the focus was less on adding more and more features but was more on to write scalable and maintainable code
* .git folder is also there so it can be used to overview my progress and assignment evolution.
* Followed mainly 4 design principles:
    * S.O.L.I.D
    * Clean architecture
    * DRY (Dont repeat yourself)
    * POLA (Principle of least astonishment)
