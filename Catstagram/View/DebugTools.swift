//
//  DebugTools.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI
import SwiftData

struct DebugTools: View {
    @Environment(\.modelContext)
    private var modelContext: ModelContext

    @Query
    private var stories: [Story]

    var body: some View {
        Button("Reset storage") {
            resetStorage()
        }
        .onAppear {
            if stories.isEmpty {
                resetStorage()
            }
        }
        .prefetch(images: stories.flatMap(\.posts).map(\.contentURL))
    }

    private func resetStorage() {
        do {
            try modelContext.transaction {
                try modelContext.delete(model: Story.self)
                try modelContext.delete(model: Post.self)
            }
            try MockStoryGenerator(modelContext: modelContext).generateStories()
        } catch {
            print(error)
        }
    }
}

#Preview {
    DebugTools()
        .modelContainer(for: [Story.self, Post.self])
}
