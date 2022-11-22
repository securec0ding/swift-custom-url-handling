//
//  UserInfoResponse.swift
//  Veracoin
//

import Foundation

struct UserInfoResponse: Codable {
    let sub: String
    let name: String
    let givenName: String
    let familyName: String
    let email: String
    let picture: String

    enum CodingKeys: String, CodingKey {
        case sub
        case name
        case givenName = "given_name"
        case familyName = "family_name"
        case email
        case picture
    }
}