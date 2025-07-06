//
//  MainScreen.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct MainScreen: View {
    @State
    private var userRepository = UserRepository()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Catstagram")
                .navigationBarTitleDisplayMode(.inline)
        }
        .environment(userRepository)
        .task {
            try? await userRepository.fetch()
        }
    }

    private var content: some View {
        ScrollView {
            VStack(spacing: 32) {
                stories
                posts
                DebugTools()
            }
        }
    }

    private var stories: some View {
        VStack(alignment: .leading) {
            Text("Stories")
                .font(.title2.bold())
                .padding(.horizontal)
            StoriesFeed()
                .frame(maxWidth: .infinity)
        }
    }

    private var posts: some View {
        VStack(alignment: .leading) {
            Text("Posts")
                .font(.title2.bold())
                .padding(.horizontal)

            Text("Stay tuned.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    MainScreen()
        .modelContainer(for: [Story.self, Post.self])
        .imageCache()
}
