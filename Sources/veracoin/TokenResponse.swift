//
//  TokenResponse.swift
//  Veracoin
//

import Foundation

struct TokenResponse: Codable {
    let tokenType: String
    let scope: String
    let expiresIn: Int
    let extExpiresIn: Int
    let accessToken: String
    let idToken: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case scope
        case expiresIn = "expires_in"
        case extExpiresIn = "ext_expires_in"
        case accessToken = "access_token"
        case idToken = "id_token"
    }
}