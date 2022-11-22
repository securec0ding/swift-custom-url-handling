//
//  ASWebAuthenticationSession.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//

import Foundation

enum WebAuthenticationError: Error {
    case badClientId
    case urlConstruction
}

extension ASWebAuthenticationSession {
    public typealias CompletionHandler = (URL?, Error?) -> Void
}

open class ASWebAuthenticationSession {    
    static var saved:ASWebAuthenticationSession?

    private var handler: ASWebAuthenticationSession.CompletionHandler?
    private var URL: URL?

    public init(url URL: URL, callbackURLScheme: String?, completionHandler: @escaping ASWebAuthenticationSession.CompletionHandler)
    {      
        self.URL = URL
        self.handler = completionHandler  
        ASWebAuthenticationSession.saved = self
    }
    
    var presentationContextProvider: UIViewController?

    @discardableResult func start() -> Bool {
        if let ws = gWebSocket {
            if let URL = URL {
                ws.send("V|W|\(URL.absoluteString)")
            }
        }

        return true
    }

    static func triggerError(_ error:Error?) {
        if let saved = saved {
            saved.mTriggerError(error)
        }
    }

    func mTriggerError(_ error:Error?) {
        if let handler = self.handler {
            handler(nil, error)
        }
    }

    static func trigger(_ clientState:String) {
        if let saved = saved {
            saved.mTrigger(clientState)
        }
    }

    func mTrigger(_ clientState:String) {
        if let handler = self.handler {

            if var urlComponents = URLComponents(string: "veracoin://oauth") {
                urlComponents.query =
                    "state=" + clientState +
                    "&code=THISISACODE123" +
                    "&scope=user.read openid profile email"

                handler(urlComponents.url, nil)
                return
            }

            handler(nil, WebAuthenticationError.urlConstruction)
        }
    }    
}