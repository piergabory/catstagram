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
    }

    private func resetStorage() {
        do {
            try modelContext.delete(model: Post.self)
            try modelContext.delete(model: Story.self)
            try MockStoryGenerator(modelContext: modelContext).generateStories()
        } catch {
            print(error)
        }
    }
}
