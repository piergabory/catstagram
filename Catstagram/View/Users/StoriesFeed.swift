//
//  StoriesFeed.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoriesFeed: View {
    @State
    private var users: [User] = []

    @Namespace
    private var transitionNamespace

    var body: some View {
        Carousel {
            stories
        }
        .navigationDestination(for: User.self) { user in
            StoryReview(user: user)
                .navigationTransition(.zoom(sourceID: user.id, in: transitionNamespace))
        }
        .task {
            do {
                users = try await UserList.loadFromUsersJSONFile().users
            } catch {
                print(error)
            }
        }
    }

    private var stories: some View {
        ForEach(users) { user in
            NavigationLink(value: user) {
                ProfilePreview(user: user)
                    .matchedTransitionSource(id: user.id, in: transitionNamespace)
            }
        }
    }
}



#Preview {
    NavigationStack {
        StoriesFeed()
    }
}
