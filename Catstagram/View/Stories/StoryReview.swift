//
//  StoryReview.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoryReview: View {
    @State
    private var viewModel: StoryReviewViewModel

    init?(_ stories: some Collection<Story>) {
        if let viewModel = StoryReviewViewModel(stories) {
            self.viewModel = viewModel
        } else {
            return nil
        }
    }

    var body: some View {
        PostView(post: viewModel.currentPost)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background()
            .colorScheme(.dark)
            .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    StoryReview([])
}
