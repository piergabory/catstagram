//
//  User.swift
//  Catstagram
//
//  Created by Pierre GABORY on 7/6/25.
//

struct User: Identifiable {
    let handle: String

    var id: String {
        handle
    }
}
