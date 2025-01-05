📱 iOS Practical Task
📝 Introduction
This project is an iOS application that demonstrates infinite scrolling of albums and their associated images. It is built using the MVVM Clean architecture and supports offline functionality using Realm as the local database.

✨ Features
Infinite Scrolling:
Vertical scrolling loops seamlessly through albums.
Horizontal scrolling loops through images within each album.
Independent Scrolling:
Albums scroll independently from one another.
Supports scrolling in all directions (up, down, left, right).
Offline Mode:
Data is stored locally with Realm for offline access.
Cached data is instantly available when the app is reopened.
API Integration:
Fetches albums and photos from the JSONPlaceholder API.
📋 Requirements
Design:
The screen should follow the provided design layout.
Architecture:
Implement the MVVM Clean architecture.
Offline Support:
Use Realm for local database storage.
🌐 APIs
Albums API:

URL: https://jsonplaceholder.typicode.com/albums
Method: GET
Photos API:

URL: https://jsonplaceholder.typicode.com/photos
Parameter: albumId
Method: GET
🚀 Installation and Setup
Clone the Repository:
bash
Copy code
git clone git@github.com:sujoy626/PracticalTask.git
Install Dependencies:
bash
Copy code
pod install  
Open the Project in Xcode:
Open the .xcworkspace file.
Build and Run the App:
Select a simulator or connected device, then build and run the project.
🔧 Usage
Launch the app to view the list of albums.
Scroll vertically to navigate through looping albums.
Tap an album to view its images.
Scroll horizontally to explore looping images within an album.
🛠️ Technologies Used
Programming Language: Swift
Frameworks: UIKit, Realm
Architecture: MVVM Clean
Networking: URLSession
📜 License
This project is licensed under the MIT License. For more details, refer to the LICENSE file.

