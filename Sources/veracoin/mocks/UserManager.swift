//
//  UserManager.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Singleton that manages users and tracks login state
//

import Foundation

enum ServiceError: Error {
    case notFound
    case invalidLogin
    case networkProblem
    case invalid
    case accountExists
    case accountDeleted
    case other
}

class UserManager {
    private var userDict = [Int: UserModel]()
    public var currentUser: UserModel?
    
    static let sharedInstance: UserManager = {
        let instance = UserManager()
        
        instance.loadUsers()
        
        return instance
    }()
    
    private func loadUsers() {
        let user100 = UserModel(id: 100, name: "John Q. Public", email: "john@example.com", password: "password", subject: "yW6evr", friends: [101, 102])
        userDict[user100.id] = user100
        
        let user101 = UserModel(id: 101, name: "Jane Doe", email: "jane@example.com", password: "supersecret", subject: "V3KhM1", friends: [100, 102])
        userDict[user101.id] = user101
        
        let user102 = UserModel(id: 102, name: "Zahir Arora", email: "zahir@example.com", password: "password", subject: "n3pjjM", friends: [101])
        userDict[user102.id] = user102
    }

    public func loginUser(id: Int) {
        if let user = userDict[id] {
            self.currentUser = user
        }
    }
    
    public func login(email:String, password:String, completion: @escaping (Result<UserModel?, ServiceError>) -> Void) {
        for (_, user) in userDict {
            if user.email == email {
                if user.password == password {
                    self.currentUser = user
                    completion(.success(user))
                    return
                }
            }
        }

        completion(.failure(.invalid))
    }

    public func verify(subject:String, completion: @escaping (Result<UserModel?, ServiceError>) -> Void) {
        for (_, user) in userDict {
            if user.subject == subject {
                self.currentUser = user
                completion(.success(user))
                return
            }
        }

        completion(.failure(.invalid))
    }

    public func findUser(id: Int) -> UserModel? {
        return userDict[id]
    }    
    
}