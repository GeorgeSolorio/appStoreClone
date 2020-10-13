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

## Models 📬
All model objects are located in the [models](https://github.com/GeorgeSolorio/appStoreClone/tree/master/appStoreClone/Model) folder.

| File                   | Description                                    | Obejcts                                  |
| -----------------------|:-----------------------------------------------|:-----------------------------------------|
| AppGroup.swift         | The root of three major Feed objects           | AppGroup, Feed, FeedResult,              |
| CustomerReviews.swift  | A set of key objects used for reviews          | Reviews, ReviewFeed, Entry, Author, Label|
| SearchResult.swift     | A set of search result keys                    | SearchResult, Result                     |
| SocialApp.swift        | Holds keys for the app image information       | SocialApp                                |
| todayItem.swift        | Holds infomations about the apps detailed data | TodayItem                                |

Each model is used for mapping JSON data into Swift decodable structs from the Itunes API

## Views 🖼
You can find the View classes in the [Views](https://github.com/GeorgeSolorio/appStoreClone/tree/master/appStoreClone/Views) folder.

| Folder                   | Description                                                                | Objects                               |
| -----------------------|:-----------------------------------------------------------------------------|:-----------------------------------------|
| Apps                   | This folder consits of files that help display details about the fetched app | AppRowCell, AppHeaderCell, AppDetailCell, PreviewCell,  ReviewInfoCell, ReviewRowCell |
| Music                  | This folder helps display infomation about a given track                     | TrackCell, MusicLoadingFooter          |
| Today                  | This folder consits of files that help display information on the Today Tab  | TodayAppFullScreenHeaderCell, BaseTodayCell, MultipleAppCell, TodayAppFullScreenDescriptionCell, TodayAppFullScreenHeaderCell, TodayCell, TodayMutipleAppsCell |

## Controller 🕹
You can find the controller classes in the [Controller](https://github.com/GeorgeSolorio/appStoreClone/tree/master/appStoreClone/Controller) folder.
| Controllers              | Description                                    |
| -------------------------|:-----------------------------------------------|
| App                      | This folder helps initialize and display the app's tab view. Using tools from SwiftUI for its collection view and displaying details about apps in the scroll view|
| Today                    | This folder consits of code that helps display four main cells. Each cell displays information, provides user interaction and creates feedback by zooming in and out of a cell in an animated way |
| Base                   | A set of base controllers consisting of common behaviours found in many of our views. These objects allow us to speed up the process initializing controllers such as the TabBarController, BaseListController and HorizontalSnappingController |
| Search                 | This folder consists of a single file that makes use of Apple's UISearchController, allowing us to fetch user input |


## Service 📥
You can find the Service class in the [Service](https://github.com/GeorgeSolorio/appStoreClone/tree/master/appStoreClone/Service) folder

## Third party services: SDWebImage 
We used SDWebImage to help us download and display images in a simpler and intuitive way 

