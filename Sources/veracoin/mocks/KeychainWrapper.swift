//
//  KeychainWrapper.swift
//  Veracoin
//
//  This is support code for the Mock Mobile Development environment
//  You should not revise this code or it may break the lesson. 
//
//  Mock KeychainWrapper
// 

import Foundation

class KeychainWrapper
{
    private var prefFile: String;
    private var preferences: [String: String];

    static let standard: KeychainWrapper = {
        let instance = KeychainWrapper("Keychain.plist")
        
        return instance
    }()

    private init(_ prefFile: String)
    {
        self.prefFile = prefFile;
        self.preferences = [:]
        load()
    }

    private func load()
    {
        let path = URL(fileURLWithPath: prefFile)

        do {
            let xml = try Data(contentsOf: path)
            preferences = try PropertyListDecoder().decode([String:String].self, from: xml)
        } catch {
            // Ignore
        }        
    }

    private func save()
    {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        let path = URL(fileURLWithPath: prefFile)

        do {
            let data = try encoder.encode(preferences)
            try data.write(to: path)
        } catch {
            // Ignore
        }        
    }

    func string(forKey defaultName: String) -> String?
    {
        return preferences[defaultName]
    }

    func set(_ value: Any?, forKey defaultName: String)
    {
        preferences[defaultName] = (value as! String);
        save()
    }
}