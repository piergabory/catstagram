//
//  StoryReviewViewModel.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import Foundation
import Observation

@Observable
final class StoryReviewViewModel {
    private let clock = SuspendingClock()
    private var autoAdvanceWaitingTask: Task<Void, Never>?

    let story: Story
    let nextStory: StoryReviewViewModel?

    private(set) var currentPostIndex = 0

    var currentPost: Post {
        story.posts[currentPostIndex]
    }

    init?(_ stories: some Collection<Story>) {
        guard let story = stories.first else { return nil }
        self.story = story
        self.nextStory = StoryReviewViewModel(stories.dropFirst())
    }

    func next() {
        if currentPostIndex < story.posts.count - 1 {
            currentPostIndex += 1
        }
    }

    func autoAdvance() async {
        while currentPostIndex < story.posts.count - 1 {
            await waitForCurrentPostDuration()
            if autoAdvanceWaitingTask?.isCancelled == false {
                // User skipped manually, ignore.
                next()
            }
        }
        // wait for the last post
        await waitForCurrentPostDuration()
    }

    private func waitForCurrentPostDuration() async {
        autoAdvanceWaitingTask = Task {
            try? await clock.sleep(for: .seconds(currentPost.duration))
        }
        await autoAdvanceWaitingTask?.value
    }
}
