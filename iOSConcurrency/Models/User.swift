//
//  User.swift
//  iOSConcurrency
//
//  Created by Aleksandr on 09.05.2025.
//

// urlString = https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
