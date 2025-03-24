//
//  TabView.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI
struct MainTabView: View {
    var body: some View {
        TabView {
            // Home Tab
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house") // Home tab with house icon
                }

            // News Tab
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper") // News tab with newspaper icon
                }
            
            // Settings Tab
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear") // Settings tab with gear icon
                }
        }
    }
}

#Preview {
    MainTabView()
}
