//
//  PostView.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI
import SwiftData

struct PostView: View {
    @Environment(\.modelContext)
    private var modelContext: ModelContext

    let post: Post
    let authorID: User.ID

    var body: some View {
        content
            .overlay(alignment: .top) {
                PostHeaderView(authorID: authorID, date: post.date)
            }
            .colorScheme(.dark)
            .onAppear {
                try? modelContext.transaction {
                    post.isSeen = true
                    try modelContext.save()
                }
            }
            .id(post)
            .transition(.opacity.animation(.linear(duration: 0)))
    }

    private var content: some View {
        PostImage(url: post.contentURL)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(.background)
    }
}

#Preview {
    @Previewable @State var userRepository = UserRepository()
    @Previewable @State var storyReview = StoryReviewViewModel([
        Story(
            userID: 2,
            posts: [Post(contentURL: URL(string: "https://picsum.photos/id/2/400/400")!, date: .now)]
        )!
    ])

    PostView(
        post: Post(
            contentURL: URL(string: "https://picsum.photos/id/2/400/400")!,
            date: .now - 2000
        ),
        authorID: 1
    )
    .environment(userRepository)
    .environment(storyReview)
    .task {
        try? await userRepository.fetch()
    }
}
