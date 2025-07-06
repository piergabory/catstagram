//
//  Author.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct Author: View {
    @Environment(UserRepository.self)
    private var userRepository: UserRepository

    private let userID: User.ID

    var user: User? {
        userRepository.getUser(id: userID)
    }

    init(_ userID: User.ID) {
        self.userID = userID
    }

    var body: some View {
        HStack {
            Avatar(url: user?.avatarURL)
                .frame(height: 32)
            Text(user?.name ?? "--")
                .font(.caption)
        }
        .fixedSize()
    }
}


#Preview {
    @Previewable @State var userRepository = UserRepository()

    Author(2)
        .environment(userRepository)
        .task {
            try? await userRepository.fetch()
        }
}
