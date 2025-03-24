//
//  SettingsView.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme  // Detects the system's color scheme (light/dark mode)
    @EnvironmentObject var darkModeManager: DarkModeManager  // Manages dark mode preference across the app
    
    var body: some View {
        VStack {
            // User greeting
            Text("Hello, Rayaheen!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            // Profile image
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            
            // User information
            Text("Rayaheen Mseri")
            Text("rayaheen@gmail.com")
            Text("joined at 2021")
            
            Spacer()
            
            // Favorite News Section
            Section {
                HStack {
                    Image(systemName: "heart")
                    Text("Favorite News")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")  // Right arrow for navigation indication
                }
            }
            .padding([.horizontal, .top])
            
            // Account Information Section
            Section {
                HStack {
                    Image(systemName: "gearshape.fill")
                    Text("Account information")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")  // Right arrow for navigation indication
                }
            }
            .padding([.horizontal, .top])
            
            // Dark Mode Toggle Section
            Section {
                HStack {
                    Image(systemName: darkModeManager.isDarkMode ? "moon.fill" : "sun.max.fill")  // Icon changes based on mode
                    Text("Dark Mode")
                    
                    Spacer()
                    
                    Toggle(isOn: $darkModeManager.isDarkMode) {
                        Text("")
                    }
                }
            }
            .padding([.horizontal, .top])
            
            Spacer()
            
            // Log Out Button
            Text("Log Out")
                .foregroundColor(darkModeManager.isDarkMode ? .black : .white)  // Adjust text color based on mode
                .background {
                    Capsule()
                        .fill(darkModeManager.isDarkMode ? .white : .black)  // Background changes with mode
                        .frame(width: 200, height: 40)
                }
            
            Spacer()
        }
        .preferredColorScheme(darkModeManager.isDarkMode ? .dark : .light)  // Apply dark/light mode preference
    }
}

#Preview {
    SettingsView()
}
