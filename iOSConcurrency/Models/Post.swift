//
//  Post.swift
//  iOSConcurrency
//
//  Created by Aleksandr on 09.05.2025.
//

// urlString = https://jsonplaceholder.typicode.com/users/1/posts

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
