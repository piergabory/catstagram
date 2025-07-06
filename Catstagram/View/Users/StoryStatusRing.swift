//
//  StoryStatusRing.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoryStatusRing: View {
    private let newStoryGradient = LinearGradient(
        colors: [.pink, .orange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    private let seenStoryGradient = LinearGradient(
        colors: [.secondary.opacity(0.5)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    let isSeen: Bool

    var body: some View {
        Circle()
            .stroke(gradient, lineWidth: 2)
            .padding(1)
            .aspectRatio(1, contentMode: .fit)
    }

    private var gradient: LinearGradient {
        if isSeen {
            seenStoryGradient
        } else {
            newStoryGradient
        }
    }
}

#Preview {
    @Previewable @State var userRepository = UserRepository()

    HStack {
        StoryStatusRing(isSeen: true)
        StoryStatusRing(isSeen: false)
    }
    .padding()
    .environment(userRepository)
    .task {
        try? await userRepository.fetch()
    }
}
