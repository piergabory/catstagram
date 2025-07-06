//
//  ProfilePreview.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct ProfilePreview: View {
    @Environment(UserRepository.self)
    private var userRepository: UserRepository

    let userID: User.ID
    let hasNewStory: Bool

    var user: User? {
        userRepository.getUser(id: userID)
    }

    var body: some View {
        VStack {
            avatarView
                .padding(4)
                .overlay {
                    StoryStatusRing(isSeen: hasNewStory == false)
                }
            handleView
        }
        .frame(width: 64)
    }

    private var avatarView: some View {
        Avatar(url: user?.avatarURL)
            .aspectRatio(1, contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.fill)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.separator, lineWidth: 1 / UIScreen.main.scale)
            }
    }

    private var handleView: some View {
        Text(user?.name ?? "?")
            .font(.caption)
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(minWidth: 0, idealWidth: 0)
    }
}

#Preview {
    ProfilePreview(userID: 1, hasNewStory: true)
    ProfilePreview(userID: 2, hasNewStory: false)
}
