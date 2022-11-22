//
//  UserModel.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  A user of the Veracoin App
//

import Foundation

struct UserModel: Equatable {
    let id: Int
    let name: String
    let email: String
    let password: String
    let subject: String
    let friends: [Int]
    
    func isFriend(userId: Int) -> Bool {
        return self.friends.contains(userId)
    }

    var balance: Int {
        get { 76 }
    }
}