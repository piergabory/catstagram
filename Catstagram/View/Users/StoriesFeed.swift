//
//  StoriesFeed.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI
import SwiftData

struct StoriesFeed: View {
    @Environment(UserRepository.self)
    private var userRepository: UserRepository

    @Query
    private var stories: [Story] = []

    @Namespace
    private var transitionNamespace

    var body: some View {
        Carousel {
            userProfiles
        }
        .navigationDestination(for: User.ID.self) { userID in
            let stories = stories.drop { story in
                story.userID != userID
            }

            StoryReview(stories)
                .navigationTransition(.zoom(sourceID: userID, in: transitionNamespace))
        }
    }

    private var userProfiles: some View {
        ForEach(stories) { story in
            NavigationLink(value: story.userID) {
                ProfilePreview(userID: story.userID, hasNewStory: story.hasUnseenPosts)
                    .matchedTransitionSource(id: story.userID, in: transitionNamespace)
            }
            .foregroundStyle(.primary)
        }
    }
}



#Preview {
    NavigationStack {
        StoriesFeed()
    }
}
