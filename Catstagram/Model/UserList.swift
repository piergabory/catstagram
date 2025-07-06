//
//  UserPage.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import Foundation

struct UserList: Decodable {
    struct Page: Decodable {
        let users: [User]
    }

    let pages: [Page]

    var users: [User] {
        pages.flatMap(\.users)
    }

    static func load(from resource: URL) async throws -> UserList {
        let data = try Data(contentsOf: resource)
        let list = try JSONDecoder().decode(UserList.self, from: data)
        return list
    }

    static func loadFromUsersJSONFile() async throws -> UserList {
        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
            return UserList(pages: [])
        }
        return try await load(from: url)
    }
}
