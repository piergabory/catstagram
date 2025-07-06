//
//  ProfilePreview.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct ProfilePreview: View {
    let user: User

    var body: some View {
        VStack {
            avatarView
                .padding(4)
                .overlay {
                    // TODO: Put the story status ring here
                }
            handleView
        }
        .frame(width: 64)
    }

    private var avatarView: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(.secondary)
    }

    private var handleView: some View {
        Text(user.handle)
            .font(.caption)
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(minWidth: 0, idealWidth: 0)
    }
}

#Preview {
    ProfilePreview(user: User(handle: "piergabory"))
}
