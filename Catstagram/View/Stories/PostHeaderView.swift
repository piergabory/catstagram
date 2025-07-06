import SwiftUI

struct PostHeaderView: View {
    let authorID: User.ID
    let date: Date

    var body: some View {
        HStack {
            Author(authorID)
            Text(date, format: .relative(presentation: .named))
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
            ExitButton()
        }
        .padding()
        .background {
            LinearGradient(colors: [.black.opacity(0.6), .clear], startPoint: .top, endPoint: .bottom)
        }
    }
}

#Preview {
    @Previewable @State var userRepository = UserRepository()

    PostHeaderView(
        authorID: 1,
        date: .now
    )
    .environment(userRepository)
    .task {
        try? await userRepository.fetch()
    }
}

