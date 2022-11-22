//
//  UIApplication.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock UIApplication passed to AppDelegate
// 

import Foundation


public class UIApplication {
    public struct OpenURLOptionsKey : Hashable, Equatable, RawRepresentable {
        public var rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension UIApplication.OpenURLOptionsKey {
    public static let sourceApplication = UIApplication.OpenURLOptionsKey(rawValue: "sourceApplication")

    public static let annotation = UIApplication.OpenURLOptionsKey(rawValue: "annotation")

    public static let openInPlace = UIApplication.OpenURLOptionsKey(rawValue: "openInPlace")
}

extension UIApplication {
    public struct LaunchOptionsKey : Hashable, Equatable, RawRepresentable {
        public var rawValue: String        

        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}