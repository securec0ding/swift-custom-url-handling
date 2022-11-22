//
//  WithdrawResponse.swift
//  Veracoin
//

import Foundation

struct WithdrawResponse: Codable {
    let userid: String
    let date: String
    let amount: Int
}