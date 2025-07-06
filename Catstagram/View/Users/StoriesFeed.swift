//
//  StoriesFeed.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoriesFeed: View {
    private let users: [User] = [User(handle: "piergabory"), User(handle: "backlon"), User(handle: "reckless")]

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
