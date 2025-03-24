//
//  NewsDetailsView.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI

struct NewsDetailsView: View {
    @Environment(\.colorScheme) var colorScheme // Detects the current color scheme (light/dark mode)
    var news: News // The selected news item to display details
    @Environment(\.dismiss) private var dismiss // Environment variable to dismiss the view
    @EnvironmentObject var darkModeManager: DarkModeManager // Access dark mode settings globally
    
    var body: some View {
        VStack {
            // Navigation bar with a back button
            HStack {
                VStack {
                    Image(systemName: "chevron.left") // Back button icon
                        .foregroundColor(darkModeManager.isDarkMode ? .white : .black)
                        .frame(width: 30, height: 30)
                        .padding()
                        .onTapGesture {
                            dismiss() // Dismisses the view when tapped
                        }
                }
                .frame(width: 0, alignment: .leading)
                
                Text("News Details") // Page title
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            // News title
            Text(news.title ?? "")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            
            // Display news image if available
            if let imageUrl = news.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView() // Shows a loading indicator while image loads
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .padding(.bottom, 30)
            } else {
                // Placeholder image when no image is available
                VStack {
                    Image(systemName: "exclamationmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray.opacity(0.2))
                }
                .frame(height: 200)
            }
            
            // News content
            Text(news.content ?? "")
                .padding(.horizontal)
            
            Spacer()
            
            // News source and publication date
            VStack(spacing: 10) {
                HStack {
                    Text("Source: ")
                        .font(.caption)
                    Text(news.source.name)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                HStack {
                    Text("Published:")
                        .font(.caption)
                    Text(extractDateFromISO8601(dateString: news.publishedAt) ?? news.publishedAt)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                // "Read More" link to open the full article in a browser
                Link("Read More", destination: URL(string: news.url)!)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light) // Applies dark mode settings
    }
    
    // Function to extract and format date from ISO 8601 format
    func extractDateFromISO8601(dateString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter() // Formatter for ISO 8601 date format
        if let date = isoFormatter.date(from: dateString) {
            return date.formatted(.dateTime.year().month().day()) // Formats date as YYYY-MM-DD
        }
        return nil // Returns nil if parsing fails
    }
}

#Preview {
    NewsDetailsView(news: News(
        source: Source(id: "the-wall-street-journal", name: "The Wall Street Journal"),
        author: "Gretchen Tarrant Gulla",
        title: "Trump Administration’s Cap on Research Costs Blocked by Judge",
        description: "Order says changes to National Institutes of Health funding formula would compromise ‘human safety and scientific integrity’",
        url: "https://www.wsj.com/health/healthcare/trump-nih-research-rate-cap-judge-blocked-1b368898",
        urlToImage: "https://images.wsj.net/im-61778049/social",
        publishedAt: "2025-03-05T21:23:11Z",
        content: "BOSTON A federal judge on Wednesday extended a freeze on the Trump administration’s changes to research funding through the National Institutes of Health, in the latest legal setback for the president… [+572 chars]"
    ))
}
