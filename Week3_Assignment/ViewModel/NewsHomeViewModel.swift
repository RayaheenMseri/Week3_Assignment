//
//  NewsHomeViewModel.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI

extension HomeView {
    
    // ViewModel responsible for loading and managing news data for the HomeView
    class NewsHomeViewModel: ObservableObject {
        
        @Published var news: [News] = []  // Holds the list of news articles
        @Published var isLoading: Bool = false  // Indicates whether data is being loaded
        @Published var erorrMessage: String?  // Holds the error message if the request fails
        @Published var showErrorAlert: Bool = false  // Controls the visibility of the error alert
        @Published var currentPage: Int = 1  // The current page for pagination
        @Published var totalPages = 0  // The total number of pages of news
        var pageSize = 10  // The number of articles per page
        private var isRequesting = false  // Prevents making multiple requests simultaneously
        
        // Function to load news data with pagination
        func loadNews() {
            
            guard !isRequesting else { return }  // Prevent making multiple requests at once
            isRequesting = true  // Mark the request as ongoing
            
            let apiKey: String = "42bcbf162bb04adba36eaf161e0013be"  // API key for News API
            let url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=\(apiKey)&sortBy=publishedAt&page=\(currentPage)&pageSize=\(pageSize)"
            
            // Ensure the URL is valid
            guard let urlString = URL(string: url) else {
                DispatchQueue.main.async {
                    print("Invalid URL")  // Log error if the URL is invalid
                }
                return
            }
            
            self.isLoading = true  // Set loading state to true while making the request
            
            // Make the network request to fetch news data
            URLSession.shared.dataTask(with: urlString) { (data, response, error) in
                
                DispatchQueue.main.async {
                    self.isLoading = false  // Set loading state to false after the request is done
                }
                
                // Handle network error
                if let error = error {
                    DispatchQueue.main.async {
                        self.erorrMessage = " Network Error:  \(error.localizedDescription)"
                        self.showErrorAlert = true  // Show error alert
                    }
                    return
                }
                
                // Ensure the response is valid and check for HTTP status code
                guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        self.erorrMessage = "Invalid Response"
                        self.showErrorAlert = true  // Show error alert for invalid response
                    }
                    return
                }
                
                print(httpResponse.statusCode)  // Log the status code of the response
                
                // Ensure that data is received
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.erorrMessage = "No Data"
                        self.showErrorAlert = true  // Show error alert for missing data
                    }
                    return
                }
                
                // Optionally print the raw response data as a string
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }
                
                // Parse the JSON data using JSONDecoder
                do {
                    print("hi")  // Debug print statement
                    let decoder = try JSONDecoder().decode(NewsResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        // Ensure we don't exceed the total number of results
                        guard self.news.count < decoder.totalResults ?? 0 else {
                            print("total \(decoder.totalResults ?? 0)")
                            return
                        }
                        
                        // Append new articles to the existing list
                        self.news.append(contentsOf: decoder.articles)
                        self.currentPage += 1  // Increment page number for pagination
                        
                        // Calculate the total number of pages based on the total results
                        if let totalResults = decoder.totalResults {
                            self.totalPages = Int(totalResults) / 10
                            print(self.totalPages)
                        }
                        
                        print("current \(self.currentPage)")  // Log current page
                        self.erorrMessage = nil  // Clear any previous error messages
                        print(decoder.articles.count)  // Log the number of articles received
                    }
                } catch {
                    // Handle JSON parsing error
                    DispatchQueue.main.async {
                        self.erorrMessage = "Error Parsing JSON: \(error.localizedDescription)"
                        print(error)
                        self.showErrorAlert = true  // Show error alert for JSON parsing error
                    }
                }
                self.isRequesting = false  // Mark the request as complete
            }.resume()  // Start the network request
        }
    }
}

//
//func fetchTotalResults() {
//    let apiKey: String = "42bcbf162bb04adba36eaf161e0013be"
//    let url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=\(apiKey)"
//
//    guard let urlString = URL(string: url) else {
//        print("Invalid URL")
//        return
//    }
//
//    URLSession.shared.dataTask(with: urlString) { (data, response, error) in
//        if let error = error {
//            DispatchQueue.main.async {
//                self.errorMessage = "Network Error: \(error.localizedDescription)"
//                self.showErrorAlert = true
//            }
//            return
//        }
//
//        guard let data = data else {
//            DispatchQueue.main.async {
//                self.errorMessage = "No Data"
//                self.showErrorAlert = true
//            }
//            return
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            let decodedResponse = try decoder.decode(NewsResponse.self, from: data)
//
//            DispatchQueue.main.async {
//                self.totalResults = decodedResponse.totalResults
//                print("Total Results: \(self.totalResults)")
//            }
//        } catch {
//            DispatchQueue.main.async {
//                self.errorMessage = "Error Parsing JSON: \(error.localizedDescription)"
//                self.showErrorAlert = true
//            }
//        }
//    }.resume()
//}
