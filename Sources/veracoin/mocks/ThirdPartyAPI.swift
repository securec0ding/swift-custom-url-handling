//
//  ThirdPartyAPI.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Sample Third Party API
//

import Foundation

class ThirdPartyAPI {
    static let sharedInstance: ThirdPartyAPI = {
        let instance = ThirdPartyAPI()
                
        return instance
    }()

    public func start(accountName: String) {
        if let ws = gWebSocket {
            ws.send("3|\(accountName)")
        }          
    }    
}