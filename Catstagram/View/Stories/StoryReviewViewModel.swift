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
        let safeIndex = min(max(0, currentPostIndex), story.posts.count - 1)
        return story.posts[safeIndex]
    }

    init?(_ stories: some Collection<Story>) {
        guard let story = stories.first else { return nil }
        self.story = story
        self.nextStory = StoryReviewViewModel(stories.dropFirst())
    }

    func next() {
        if currentPostIndex < story.posts.count {
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
        let duration = currentPost.duration
        autoAdvanceWaitingTask = Task.detached { [clock] in
            try? await clock.sleep(for: .seconds(duration))
        }
        await autoAdvanceWaitingTask?.value
    }
}
