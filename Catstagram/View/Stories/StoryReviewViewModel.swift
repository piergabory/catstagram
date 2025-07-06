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
}
