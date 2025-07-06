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

    private var sortedStories: [Story] {
        // Ideally i'd use query but it's a computed var, i don't have time to fix it.
        stories.sorted { lhs, rhs in lhs.hasUnseenPosts }
    }

    var body: some View {
        Carousel {
            userProfiles
        }
        .navigationDestination(for: User.ID.self) { userID in
            let stories = sortedStories.drop { story in
                story.userID != userID
            }

            StoryReview(stories)
                .navigationTransition(.zoom(sourceID: userID, in: transitionNamespace))
        }
        .prefetch(images: userRepository.users.map(\.avatarURL))
    }

    private var userProfiles: some View {
        ForEach(sortedStories) { story in
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
    .imageCache()
}
