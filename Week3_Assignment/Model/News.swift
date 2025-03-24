//
//  News.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import Foundation


enum NewsCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case business = "Business"
    case vehicles = "Vehicles"
    case technology = "Techcrunch"
    
    var id: String { self.rawValue }
}

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int?
    let articles: [News]
}

struct News: Codable, Identifiable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    var id: String {
        url + UUID().uuidString
    }

}
struct Source: Codable {
    let id: String?
    let name: String
}



