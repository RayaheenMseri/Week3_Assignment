//
//  NewsSectionView.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI
import SDWebImageSwiftUI

@ViewBuilder
func NewsSectionView(news: News, isDarkMode: Bool) -> some View {
    Section {
        HStack {
            // Load news image if available
            if let imageUrl = news.urlToImage, let url = URL(string: imageUrl) {
                WebImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView() // Show loading indicator while the image loads
                }
                .frame(width: 130, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                
            } else {
                // Placeholder if no image is available
                VStack {
                    Image(systemName: "exclamationmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(isDarkMode ? .white : .gray.opacity(0.2))
                }
                .frame(width: 130, height: 130)
            }
            
            // News title and description
            VStack(alignment: .leading) {
                Text(news.title ?? "")
                    .font(.headline)
                    .lineLimit(2) // Prevents overflow
                
                Text(news.description ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(3) // Limits text to 3 lines for readability
            }
            .frame(height: 130)
        }
    }
}
