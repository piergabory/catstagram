//
//  LikeButton.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//


import SwiftUI
import SwiftData

struct LikeButton: View {
    @Environment(\.modelContext)
    private var modelContext: ModelContext

    let post: Post

    var body: some View {
        Button {
            markAsLiked()
        } label: {
            let label = if post.isLiked {
                Label("Un-Like", systemImage: "heart.fill")
                    .foregroundStyle(.red)
            } else {
                Label("Like", systemImage: "heart")
                    .foregroundStyle(.white)
            }

            label
                .id(post.isLiked)
                .transition(.scale.animation(.bouncy))
                .padding()
        }
        .labelStyle(.iconOnly)
        .shadow(radius: 5)
        .font(.title)
    }

    private func markAsLiked() {
        try? modelContext.transaction {
            post.isLiked.toggle()
            try modelContext.save()
        }
    }
}
