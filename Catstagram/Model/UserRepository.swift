//
//  UserRepository.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

import Foundation

@Observable
final class UserRepository {
    private(set) var users: [User] = []

    func fetch() async throws {
        users = try await UserList.loadFromUsersJSONFile().users
    }

    func getUser(id: User.ID) -> User? {
        users.first(where: { $0.id == id })
    }
}
