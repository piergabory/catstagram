//
//  User.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import Foundation

struct User: Identifiable, Hashable, Decodable {
    let id: Int
    let name: String
    let avatarURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "profile_picture_url"
    }

    static let mockUser = User(id: 0, name: "piergabory", avatarURL: URL(string: "/dev/null")!)
}
