//
//  StoryReview.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoryReview: View {
    let user: User

    var body: some View {
        Text(user.name)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background()
            .colorScheme(.dark)
            .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    StoryReview(user: .mockUser)
}
