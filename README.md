# appStoreClone

## About
A case study based on Brian Voong's tutorials on iOS. The app attempts to mock Apple's App Store behavior. 
These behaviors consist of fetching iTunes data, display multiple tab controllers, display data in scroll views and presenting animation.

The project follows the MVC artchitecture along with an API service class. 
The entire app consits of four different tab controllers that demonstrate the data in four different ways

* Music tab consist of a Table View list with songs from Taylor Swift

* Today tab consists of todays' highly rated apps.

* Apss tab containing scrolls views that demonstrate a list of an editor's choice, top free iphone apps and top grossing apps.

* A search tab that allows the user to search any app they look for

Each tab has it's own Model, View and Controller. The view's were also manually coded in order to gain better access of its size and display.

## Learning Objectives
* How to set up User interface
* Fetch Itunes data and convert JSON data into Swift decodable obejects
* Synchronize multiple fetches
* Snapping collection view layouts
* Handle user selection
* Handle user interaction with animation for feedback
* Manually type auto layout contraints
* Setup navigation views and tab controllers
* Setup transitions to other views

## Usage
You can run this project on Xcode and simulate the app on any desired Iphone simulator.
Each tab will show data recieved from the iTunes API

## Models
All model objects are located in the [models](https://github.com/GeorgeSolorio/appStoreClone/tree/master/appStoreClone/Model) folder.

| File                   | Description                                    | Attributes                               |
| -----------------------|:-----------------------------------------------|:-----------------------------------------|
| AppGroup.swift         | The root of three major Feed objects           | AppGroup, Feed, FeedResult,              |
| CustomerReviews.swift  | A set of key objects used for reviews          | Reviews, ReviewFeed, Entry, Author, Label|
| SearchResult.swift     | A set of search result keys                    | SearchResult, Result                     |
| SocialApp.swift        | Holds keys for the app image information       | SocialApp                                |
| todayItem.swift        | Holds infomations about the apps detailed data | TodayItem                                |

Each model is used for mapping JSON data into Swift decodable structs from the Itunes API

## Views
You can find the View classes in the [Views](https://github.com/GeorgeSolorio/appStoreClone/tree/master/appStoreClone/Views) folder.

## Controller
You can find the controller classes in the [Controller](https://github.com/GeorgeSolorio/appStoreClone/tree/master/appStoreClone/Controller) folder.

## Service
You can find the Service class in the [Service](https://github.com/GeorgeSolorio/appStoreClone/tree/master/appStoreClone/Service) folder
