//
//  StoryProgressTimeline.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoryProgressTimeline: View {
    @Environment(StoryReviewViewModel.self)
    private var review

    var body: some View {
        HStack {
            ForEach(review.story.posts.indices, id: \.self) { index in
                if index < review.currentPostIndex {
                    Rectangle().fill(.primary)
                } else if index > review.currentPostIndex {
                    Rectangle().fill(.fill)
                } else {
                    currentPageProgress
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 2)
    }

    private var completedPage: some View {
        Rectangle()
    }

    private var remainingPage: some View {
        Rectangle()
            .fill(.fill)
    }

    private var currentPageProgress: some View {
        GeometryReader { proxy in
            PhaseAnimator([0, 1]) { phase in
                Rectangle()
                    .fill(.primary)
                    .frame(width: proxy.size.width * phase)
            } animation: { phase in
                if phase == 1 {
                    .linear(duration: review.currentPost.duration)
                } else {
                    nil
                }
            }
        }
        .background(.fill)
    }
}


#Preview {
    @Previewable @State var storyReview = StoryReviewViewModel([
        Story(
            userID: 2,
            posts: [
                Post(contentURL: URL(string: "https://picsum.photos/id/2/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/3/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/4/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/5/400/400")!, date: .now)
            ]
        )!
    ])

    StoryProgressTimeline()
        .environment(storyReview)
        .padding()
}
