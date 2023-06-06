//
//  Auth.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-06.
//

import Foundation

extension Letterboxd {
    public struct LoginTokenResponse:Codable {
        public var token:String
    }
    
    public struct UploadURLResponse:Codable {
        public let url:String
    }
    
    public struct UsernameCheckResonse:Codable {
        public let result:Result
        
        public enum Result:String, Codable {
           case available = "Available"
            case notAvailable = "NotAvailable"
            case tooShort = "TooShort"
            case tooLong = "TooLong"
            case invalid = "Invalid"
        }
    }
}
