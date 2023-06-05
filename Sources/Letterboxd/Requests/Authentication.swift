//
//  File.swift
//  
//
//  Created by Dylan Southard on 2023-06-05.
//

import Foundation

extension Letterboxd {
    public static func fetchAuthToken(username:String, password:String, onComplete:@escaping (Result<Void, Error>)->Void = {result in}) {
        
        let bodyParams: [String: String] = [
            "grant_type": "password",
            "username": username,
            "password": password
        ]
        
        tokenManager.fetchToken(bodyParams: bodyParams, onComplete: onComplete)
    }
}
