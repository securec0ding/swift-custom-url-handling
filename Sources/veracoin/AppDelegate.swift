//
//  AppDelegate.swift
//  Veracoin
//
//  This is a mocked AppDelegate and where most of the lesson code changes
//  will be made.
//

import Foundation

class AppDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Start 3rd Party API
        ThirdPartyAPI.sharedInstance.start(accountName: "BadApiCoAccount")

        // Login user:
        // UserManager.sharedInstance.loginUser(id: 101)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
    {
        // Determine who sent the URL.
        let _ = options[.sourceApplication]

        // Process the URL.
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let command = components.path,
            let params = components.queryItems else {
                print("Invalid URL or command missing")
                return false
        }

        if command == "showfriend" {
            for queryItem in params {
                if queryItem.name == "id" {
                    Router.sharedInstance.showFriend(id: Int(queryItem.value!)!)
                    return true
                }
            }
        }

        return false
    }

}