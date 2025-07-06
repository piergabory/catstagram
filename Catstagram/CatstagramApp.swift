//
//  CatstagramApp.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI
import SwiftData

@main
struct CatstagramApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .modelContainer(for: [Story.self, Post.self])
                .imageCache()
        }
    }
}
