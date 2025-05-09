//
//  PostsListViewModel.swift
//  iOSConcurrency
//
//  Created by Aleksandr on 09.05.2025.
//

import Foundation

class PostsListViewModel {
    
    private var posts: [Post] = [] {
        didSet {
            onPostsUpdated?()
        }
    }
    
    public var onPostsUpdated: (() -> Void)?
    
    public func fetchPosts(of userId: Int) {
        let apiService = APIService(urlSting: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
        apiService.fetchJSON { (result: Result<[Post], APIError>) in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                    self.onPostsUpdated?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getPostsCount() -> Int {
        return posts.count
    }
    
    public func getPost(at index: Int) -> Post? {
        guard index >= 0 && index < posts.count else {
            return nil
        }
        return posts[index]
    }
    
}
