# 🎬 Batman Movies App

![SwiftUI](https://img.shields.io/badge/SwiftUI-Enabled-blue?logo=swift)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey?logo=apple)

---

## 🦇 Overview  

**Batman Movies App** is a SwiftUI-based iOS application that displays a catalog of **Batman movies** fetched from the [OMDb API](https://www.omdbapi.com/).  

Users can scroll through a responsive grid of movie posters and tap on any item to see more details.

---

## 🌐 API Information  

This app connects to the **OMDb API (Open Movie Database)**, which provides metadata about movies, including title, year, IMDb ID, and poster URL.

**Endpoint used:**
```bash
https://www.omdbapi.com/?apikey=YOUR_API_KEY&s=batman&type=movie&page=2
```
---
## ⚙️ How to Run the App

🧩 Requirements

Xcode: 15.4 or newer (tested on Xcode 26.0)

iOS Deployment Target: iOS 17.0+

Frameworks: SwiftUI, Foundation

---
## ☑️ Setup Steps

1. Clone this repository
2. Open the project in Xcode

   Double-click the .xcodeproj or .xcworkspace file.

   Wait for Swift Package Manager to resolve dependencies automatically.

3. Add your OMDb API key

   ```bash
   guard let url = URL(string: "https://www.omdbapi.com/?apikey=YOUR_API_KEY&s=batman&type=movie&page=2")
   ```
4. Build and run the project

5. Enjoy the app!
