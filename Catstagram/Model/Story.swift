import SwiftData
import Foundation

@Model
final class Story: Identifiable {
    @Attribute(.unique)
    var userID: User.ID

    var posts: [Post]

    var id: User.ID {
        userID
    }

    var hasUnseenPosts: Bool {
        posts.contains { $0.isSeen == false }
    }

    init?(userID: User.ID, posts: [Post]) {
        if posts.isEmpty { return nil }
        self.userID = userID
        self.posts = posts
    }
}

@Model
final class Post {
    var contentURL: URL
    var duration: TimeInterval = 5.0
    var isSeen = false
    var isLiked = false

    @Relationship(inverse: \Story.posts)
    var story: Story?

    init(contentURL: URL, duration: TimeInterval = 5.0, isSeen: Bool = false, isLiked: Bool = false) {
        self.contentURL = contentURL
        self.duration = duration
        self.isSeen = isSeen
        self.isLiked = isLiked
    }
}
