//
//  StoriesFeed.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import SwiftUI

struct StoriesFeed: View {
    private let users: [User] = [User(handle: "piergabory"), User(handle: "backlon"), User(handle: "reckless")]

    var body: some View {
        Carousel {
            stories
        }
    }

    private var stories: some View {
        ForEach(users) { user in
            Text(user.handle)
        }
    }
}



#Preview {
    StoriesFeed()
}
