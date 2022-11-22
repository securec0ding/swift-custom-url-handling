//
//  VeracoinAPI.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mocked Veracoin API
//

import Foundation

class VeracoinAPI {
    static let sharedInstance: VeracoinAPI = {
        let instance = VeracoinAPI()
                
        return instance
    }()

    public func reportPosition(location: CLLocation) {
        if let ws = gWebSocket {
            ws.send("Loc|\(location.coordinate.latitude)|\(location.coordinate.longitude)")
        }          
    }    
}