//
//  Router.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Singleton for Routing on mock phone
//

import Foundation

class Router {
    static let sharedInstance = Router()
    
    func showFriend(id: Int) {
        
        if let user = UserManager.sharedInstance.findUser(id: id) {
            if let ws = gWebSocket {
                ws.send("V|F|\(user.name)")
            }
        } else {
            if let ws = gWebSocket {
                ws.send("V|F|Not found")
            }
        }
    }

    func showLogin() {
        if let ws = gWebSocket {
            ws.send("V|L")
        }
    }    

    func showHome() {
        if let ws = gWebSocket {
            ws.send("V|M")
        }
    }    

    func showForbidden() {
        if let ws = gWebSocket {
            ws.send("V|X")
        }
    }    

    func showWithdraws() {
        if let ws = gWebSocket {
            ws.send("V|W")
        }
    }    
}