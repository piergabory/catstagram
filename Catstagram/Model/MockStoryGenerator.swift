//
//  MockStoryGenerator.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import Foundation
import SwiftData

struct MockStoryGenerator {
    let modelContext: ModelContext

    func generateStories() throws {
        try modelContext.transaction {
            for index in 0 ... 30 {
                let randomlyGeneratedPosts = generateRandomPosts()
                for post in randomlyGeneratedPosts {
                    modelContext.insert(post)
                }

                if let story = Story(userID: index, posts: randomlyGeneratedPosts) {
                    modelContext.insert(story)
                }
            }
            try modelContext.save()
        }
    }

    private func generateRandomPosts() -> [Post] {
        let postCount = Int.random(in: 0 ... 8)
        return (0 ..< postCount).map { index in
            let width = Int.random(in: 350...450)
            let height = Int.random(in: 750...850)
            let content = URL(string: "https://placecats.com/\(width)/\(height)")!
            let date = Date.now - TimeInterval.random(in: 0 ... 30000)

            return Post(contentURL: content, date: date)
        }
    }
}
