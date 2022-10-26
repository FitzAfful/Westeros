# Westeros

Westeros lists the houses in Game of Thrones from [An API of Ice And Fire](https://anapioficeandfire.com/) and their details.

### Project Structure
Westeros uses MVVM as a pattern. Every View is attached to a ViewModel and listens to published values in the View Model.
Requests are made in Repositories (CharacterRepository and HouseRepository) and the result passed to a View Model.
Helpers contain extensions and custom files used int the project. 
Model contains Model classes that store data from the API

* Data
  * APIClient
  * Model
  * Repository
* Modules
  * HouseList
  * HouseDetail
* Helpers
  * Font
* Assets


### Screenshots
Launch Screen             |  List |  Details
:-------------------------:|:-------------------------:|:-------------------------:
![alt text](https://github.com/FitzAfful/Westeros/blob/main/Screenshots/Launch.png)  |   ![alt text](https://github.com/FitzAfful/Westeros/blob/main/Screenshots/List.png)  |   ![alt text](https://github.com/FitzAfful/Westeros/blob/main/Screenshots/Details.png) 


### Libraries/Frameworks Used
* [SwiftUI](https://developer.apple.com/xcode/swiftui/)
* [Combine](https://developer.apple.com/documentation/combine)

### Project Requirements
* iOS 14.0+
* Xcode 13+
* Swift 5.0+

