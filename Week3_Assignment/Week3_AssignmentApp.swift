//
//  Week3_AssignmentApp.swift
//  Week3_Assignment
//
//  Created by Rayaheen Mseri on 21/09/1446 AH.
//

import SwiftUI

@main
struct Week3_AssignmentApp: App {
    @StateObject private var darkModeManager = DarkModeManager()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(darkModeManager)
        }
    }
}
