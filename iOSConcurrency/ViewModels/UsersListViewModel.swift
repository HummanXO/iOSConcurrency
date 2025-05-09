//
//  UsersListViewModel.swift
//  iOSConcurrency
//
//  Created by Aleksandr on 09.05.2025.
//

import Foundation

class UsersListViewModel {
    private var users: [User] = [] {
        didSet {
            onUsersChanged?()
        }
    }
    
    public var onUsersChanged: (() -> Void)?
    
    public func fetchUsers() {
        let apiServise = APIService(urlSting: "https://jsonplaceholder.typicode.com/users")
        apiServise.fetchJSON { (result: Result<[User], APIError>) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                    self.onUsersChanged?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getUsersCount() -> Int {
        return users.count
    }
    
    public func getUserForIndex(_ index: Int) -> User? {
        guard index >= 0 && index < users.count else {
            return nil
        }
        return users[index]
    }
}
