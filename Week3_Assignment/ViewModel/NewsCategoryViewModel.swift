//
//  NewsCategoryViewModel.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI
import Alamofire

extension NewsView {
    // ViewModel responsible for loading news based on category and handling API responses
    class NewsCategoryViewModel: ObservableObject {
        @Published var news: [News] = []  // Holds the list of news articles
        @Published var showErrorAlert: Bool = false  // Controls the visibility of the error alert
        @Published var errorMessage: String = ""  // Stores the error message for failed requests
        @Published var isLoading: Bool = false  // Indicates whether data is currently being loaded
        
        // Function to load news articles based on a specific category
        func loadCategories(category: NewsCategory) {
            news = []  // Reset news array before loading new data
            self.isLoading = true  // Set loading state to true
            
            let apiKey: String = "42bcbf162bb04adba36eaf161e0013be"
            var url = ""
            
            // Setting the API URL based on the selected category
            switch category {
            case .business:
                url = "https://newsapi.org/v2/top-headlines?country=us&category=\(category.rawValue)&apiKey=\(apiKey)"
            case .technology:
                url = "https://newsapi.org/v2/top-headlines?sources=\(category.rawValue)&apiKey=\(apiKey)"
            case .vehicles:
                // URL specific to vehicle-related news (e.g., Tesla)
                url = "https://newsapi.org/v2/everything?q=Tesla&sortBy=publishedAt&apiKey=\(apiKey)&from=22-3-2025"
            case .all:
                loadNews()  // If category is "all", load news from multiple sources
                return
            }
            
            // API request using Alamofire
            AF.request(url, method: .get).responseDecodable(of: NewsResponse.self) { response in
                DispatchQueue.main.async {
                    self.isLoading = false  // Set loading to false after request completion
                    
                    switch response.result {
                    case .success(let newsResponse):
                        // Add articles to the news array if they aren't already present
                        for article in newsResponse.articles {
                            if !self.news.contains(where: { $0.url == article.url }) {
                                self.news.append(article)
                            }
                        }
    
                    case .failure(let error):
                        // Show error if request fails
                        self.errorMessage = error.localizedDescription
                        self.showErrorAlert = true
                    }
                }
            }
        }
        
        // Function to load news from multiple sources
        let dispatchGroup = DispatchGroup()
        func loadNews() {
            self.isLoading = true  // Set loading to true
            
            let apiKey: String = "42bcbf162bb04adba36eaf161e0013be"
            let stringUrls = [
                "https://newsapi.org/v2/everything?q=Tesla&sortBy=publishedAt&apiKey=42bcbf162bb04adba36eaf161e0013be&from=22-3-2025",
                "https://newsapi.org/v2/top-headlines?country=us&category=\(NewsCategory.business.rawValue)&apiKey=\(apiKey)",
                "https://newsapi.org/v2/top-headlines?sources=\(NewsCategory.technology.rawValue)&apiKey=\(apiKey)"
            ]
            
            // Iterate through URLs to fetch news from multiple sources
            for urlString in stringUrls {
                dispatchGroup.enter()  // Enter dispatch group to wait for multiple API calls
                
                guard let url = URL(string: urlString) else {
                    // Handle invalid URL error
                    self.errorMessage = "Invalid URL"
                    self.showErrorAlert = true
                    return
                }
                
                // API request for each URL
                AF.request(url, method: .get).responseDecodable(of: NewsResponse.self) { response in
                    DispatchQueue.main.async {
                        self.isLoading = false  // Set loading to false after request completion
                        
                        switch response.result {
                        case .success(let newsResponse):
                            self.news.append(contentsOf: newsResponse.articles)  // Add received articles to the array
                            
                        case .failure(let error):
                            // Show error if request fails
                            self.errorMessage = error.localizedDescription
                            self.showErrorAlert = true
                        }
                    }
                }
                dispatchGroup.leave()  // Leave dispatch group after API call is done
            }
        }
    }
}
