//
//  NewsView.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI
struct NewsView: View {
@Environment(\.colorScheme) var colorScheme  // Detects the current color scheme (light/dark mode)
@StateObject var viewModel = NewsCategoryViewModel()  // ViewModel to handle news fetching and state
@State private var selectedCategory: NewsCategory = .all  // Keeps track of the selected news category
@State var selectedNews: News? = nil  // Holds the currently selected news item for full-screen display
@EnvironmentObject var darkModeManager: DarkModeManager  // Manages dark mode preference across the app

var body: some View {
    VStack {
        // Title
        Text("News 📰")
            .font(.title)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

        // Category selection menu
        HStack {
            Text("Category")
            
            Menu {
                ForEach(NewsCategory.allCases) { category in
                    Button(action: {
                        selectedCategory = category
                        viewModel.loadCategories(category: category)  // Load news based on selected category
                    }) {
                        Label(category.rawValue, systemImage: category == selectedCategory ? "checkmark" : "")
                            .foregroundColor(.primary)
                    }
                }
            } label: {
                // Styling for the selected category button
                Text(selectedCategory.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(darkModeManager.isDarkMode ? Color.gray.opacity(0.2) : Color.gray.opacity(0.05))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal)

        // Divider for section separation
        Divider()
            .padding(.horizontal)
            .padding(.top, 10)

        Spacer()

        // Show loading indicator while fetching news
        if viewModel.isLoading {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
            
            Spacer()
        }
        // Display message if no news is found
        else if viewModel.news.isEmpty {
            Text("No News Found")
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
        }
        // Display news list
        else {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.news, id: \.title) { news in
                        VStack {
                            NewsSectionView(news: news, isDarkMode: darkModeManager.isDarkMode)
                            Divider().padding([.top, .bottom], 4)
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            selectedNews = news  // Open news details when tapped
                        }
                    }
                }
            }
        }
    }
    .onAppear {
        Task {
            viewModel.loadNews()  // Fetch news when the view appears
        }
    }
    .alert(isPresented: $viewModel.showErrorAlert) {
        Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
    }
    .fullScreenCover(item: $selectedNews) { news in
        NewsDetailsView(news: news)  // Show full-screen news details when a news item is selected
    }
    .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)  // Apply dark/light mode based on settings
}
}

#Preview {
    NewsView()
}
