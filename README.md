# News Application

## Overview

This is a multi-screen news application built using SwiftUI, designed to fetch and display news data from the News API. The app utilizes both **URLSession** and **Alamofire** to retrieve the latest headlines and category-specific news. It follows the **MVVM (Model-View-ViewModel)** architecture, ensuring a clean and maintainable codebase.

## Features

1. **Fetching News:**
   - The app uses **URLSession** and **Alamofire** to fetch news data.
   - Displays the latest headlines and allows category-specific news retrieval.

2. **Pagination:**
   - Implements pagination by fetching the next set of news articles when the user scrolls to the bottom.

3. **Multiple Screens:**
   - **Home Screen**: Displays the latest headlines.
   - **Category-Based News Screen**: Displays news filtered by categories such as:
     - All
     - Business
     - Vehicles
     - Technology (Techcrunch)
   - **News Detail Screen**: Displays the full article when tapped, including additional information like the source and published date.

4. **MVVM Architecture:**
   - Implements **MVVM** to ensure a clean separation of concerns between the model, view, and view model.

5. **Error Handling and Loading Indicators:**
   - Shows loading indicators while fetching news.
   - Displays appropriate error messages if data fetching fails.

6. **UI/UX:**
   - The User Interface is designed following **Apple Human Interface Guidelines** and **SwiftUI best practices** for a smooth, intuitive, and responsive user experience.

## Screens

### Home Screen - Latest News
- Displays the latest headlines fetched from the News API.
- Each article contains:
  - Title
  - Image (if available)
  - Brief summary
- Includes a "Load More" button that fetches the next set of articles.
- Tapping on an article navigates to the **News Detail Screen**.

### Category-Based News Screen
- Displays news articles filtered by categories such as:
  - **All**
  - **Business**
  - **Vehicles**
  - **Technology** (Techcrunch)
- Fetches category-specific news by querying the API with the selected category.

### News Detail Screen
- Displays the full article, including:
  - Image
  - Title
  - Content
  - **Source** (the original source of the news)
  - **Published Date** (the date the article was published)
- Includes a "Read More" button that opens the full article in the browser for external reading.

## Architecture

The application uses the **MVVM** architecture to ensure a separation of concerns:

- **Model**: Represents the data structure (news articles, API responses).
- **View**: Contains the UI components and handles user interactions.
- **ViewModel**: Acts as a middle layer that connects the view and the model. It fetches data, manages state, and provides data to the view.

## News API Integration

The app utilizes the News API from [newsapi.org](https://newsapi.org/) to fetch the required news data. The API key needs to be added to the project in order to make requests. Alternatively, you can use any other free API to fetch news.

## How to Run the Project

### Prerequisites
- Xcode 12 or later
- Swift 5.0 or later
- Alamofire (installed via Swift Package Manager or CocoaPods)
- SDWebImageSwiftUI (installed via Swift Package Manager or CocoaPods)

### Steps to Run
1. Clone or download the repository.
2. Open the project in Xcode.
3. Add your **News API key** to the project:
   - Go to `APIManager.swift` (or wherever the API key is configured) and insert your API key from [newsapi.org](https://newsapi.org/).
4. Build and run the project in Xcode.
5. The app will now display the latest headlines on the Home Screen, allow filtering by categories, and navigate to the News Detail Screen when an article is tapped.

## Conclusion

This project demonstrates how to build a modern news application using **MVVM architecture**, **SwiftUI**, and **Alamofire** for fetching data from the **News API**. It features multiple screens, pagination, and error handling, all while adhering to **Apple's Human Interface Guidelines** for an optimal user experience.

Feel free to clone the repository and extend the functionality further!
