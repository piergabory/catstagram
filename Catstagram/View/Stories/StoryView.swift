//
//  StoryView.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoryView: View {
    @Environment(StoryReviewViewModel.self)
    private var review
    private let onFinishedStory: () -> Void

    init(onFinishedStory: @escaping () -> Void) {
        self.onFinishedStory = onFinishedStory
    }

    var body: some View {
        postView
            .onTapGesture {
                review.next()
            }
            .overlay(alignment: .bottomTrailing) {
                LikeButton(post: review.currentPost)
                    .padding()
            }
            .overlay(alignment: .top) {
                PostHeaderView(authorID: review.story.userID, date: review.currentPost.date)
            }
            .task {
                await review.autoAdvance()
                onFinishedStory()
            }
            .id(review.story.userID)
    }

    private var postView: some View {
        PostView(post: review.currentPost, authorID: review.story.userID)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background()
    }
}

#Preview {
    @Previewable @State var userRepository = UserRepository()
    @Previewable @State var storyReview = StoryReviewViewModel([
        Story(
            userID: 2,
            posts: [
                Post(contentURL: URL(string: "https://picsum.photos/id/2/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/3/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/4/400/400")!, date: .now)
            ]
        )!
    ])

    StoryView {

    }
    .environment(userRepository)
    .environment(storyReview)
    .task {
        try? await userRepository.fetch()
    }
    .imageCache()
}

