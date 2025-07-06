//
//  PostView.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct PostView: View {
    let post: Post
    let authorID: User.ID

    var body: some View {
        content
            .overlay(alignment: .top) {
                PostHeaderView(authorID: authorID, date: post.date)
            }
            .colorScheme(.dark)
    }

    private var content: some View {
        AsyncImage(url: post.contentURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure(let error):
                VStack {
                    Image(systemName: "xmark.circle")
                    Text(error.localizedDescription)
                }
            @unknown default:
                VStack {
                    Image(systemName: "xmark.circle")
                    Text("API changed!")
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.background)
    }
}

#Preview {
    @Previewable @State var userRepository = UserRepository()

    PostView(
        post: Post(
            contentURL: URL(string: "https://picsum.photos/id/2/400/400")!,
            date: .now - 2000
        ),
        authorID: 1
    )
    .environment(userRepository)
    .task {
        try? await userRepository.fetch()
    }
}
