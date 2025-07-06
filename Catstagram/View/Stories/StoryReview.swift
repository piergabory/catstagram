//
//  StoryReview.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoryReview: View {
    @Environment(\.dismiss)
    private var dismiss: DismissAction

    @State
    private var viewModel: StoryReviewViewModel

    init?(_ stories: some Collection<Story>) {
        if let viewModel = StoryReviewViewModel(stories) {
            self.viewModel = viewModel
        } else {
            return nil
        }
    }

    var body: some View {
        storyView
            .colorScheme(.dark)
            .toolbarVisibility(.hidden, for: .navigationBar)
            .environment(viewModel)
    }

    private var skipStoryGesture: some Gesture {
        DragGesture(minimumDistance: 20).onEnded { gesture in
            if gesture.translation.width > 0 {
                jumpToNextStory()
            }
        }
    }

    private var storyView: some View {
        StoryView {
            jumpToNextStory()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background.secondary)
        .contentShape(Rectangle())
        .simultaneousGesture(skipStoryGesture)
    }

    private func jumpToNextStory() {
        if let nextStory = viewModel.nextStory {
            viewModel = nextStory
        } else {
            dismiss()
        }
    }
}

#Preview {
    @Previewable @State var userRepository = UserRepository()

    StoryReview([
        Story(
            userID: 2,
            posts: [
                Post(contentURL: URL(string: "https://picsum.photos/id/2/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/3/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/4/400/400")!, date: .now)
            ]
        )!,
        Story(
            userID: 4,
            posts: [
                Post(contentURL: URL(string: "https://picsum.photos/id/2/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/3/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/4/400/400")!, date: .now)
            ]
        )!,
        Story(
            userID: 6,
            posts: [
                Post(contentURL: URL(string: "https://picsum.photos/id/2/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/3/400/400")!, date: .now),
                Post(contentURL: URL(string: "https://picsum.photos/id/4/400/400")!, date: .now)
            ]
        )!
    ])
    .environment(userRepository)
    .task {
        try? await userRepository.fetch()
    }
}
