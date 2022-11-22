//
//  OAuthHelper.swift
//  Veracoin
//

import Foundation
import Crypto

extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
    
    var base64: String {
        data.base64EncodedString()
    }
}

class OAuthHelper {
    static let stateLength = 32
    static let codeVerifierLength = 128
    static let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    class func randomString(length: Int) -> String
    {
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    class func generateState() -> String {
        return randomString(length: stateLength)
    }

    class func generateCodeVerifier() -> String {
        return randomString(length: codeVerifierLength)
    }
    
    class func createCodeChallenge(codeVerifier: String) -> String {
        let inputData = Data(codeVerifier.utf8)
        let hashed = Data(SHA256.hash(data: inputData))
        let base64 = hashed.base64EncodedString().replacingOccurrences(of: "+", with: "-").replacingOccurrences(of: "/", with: "_")
        return String(base64.dropLast())
    }    
    
}