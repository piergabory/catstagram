import SwiftUI

struct PostHeaderView: View {
    let authorID: User.ID
    let date: Date

    var body: some View {
        VStack {
            StoryProgressTimeline()
            toolbar
        }
        .padding()
        .colorScheme(.dark)
        .background {
            LinearGradient(colors: [.black.opacity(0.6), .clear], startPoint: .top, endPoint: .bottom)
        }
    }

    private var toolbar: some View {
        HStack {
            Author(authorID)
            Text(date, format: .relative(presentation: .named))
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
            ExitButton()
        }
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

    PostHeaderView(
        authorID: 1,
        date: .now
    )
    .environment(userRepository)
    .environment(storyReview)
    .task {
        try? await userRepository.fetch()
    }
}

