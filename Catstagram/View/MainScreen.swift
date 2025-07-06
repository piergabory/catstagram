//
//  MainScreen.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Catstagram")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var content: some View {
        ScrollView {
            VStack(spacing: 32) {
                stories
                posts
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
}
