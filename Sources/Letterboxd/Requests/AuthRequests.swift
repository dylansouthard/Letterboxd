//
//  File.swift
//  
//
//  Created by Dylan Southard on 2023-06-05.
//

import Foundation

extension Letterboxd {
    
    //TODO: === POST /auth/forgotten-password-request ===
    
    //TODO: - === GET /auth/get-login-token ===
    
    //TODO: - === GET /auth/get-upload-url ===
    
    //TODO: === POST /auth/revoke ===

    
    //MARK: - === POST auth/token ===
    /**
     Retrieves an authentication token using a username and password.

     - API Endpoint: POST /auth/token
     - Parameters:
       - username: The user's username.
       - password: The user's password.
     - Parameter onComplete: The closure to be invoked when the request is complete. It contains a result type that represents either a successful Void request or an Error.
     */
    public static func fetchAuthToken(username:String, password:String, onComplete:@escaping (Result<Void, Error>)->Void = {result in}) {
        
        let bodyParams: [String: String] = [
            "grant_type": "password",
            "username": username,
            "password": password
        ]
        
        tokenManager.fetchToken(bodyParams: bodyParams, onComplete: onComplete)
    }
    
    
    //MARK: - === GET /auth/get-upload-url ===
    /**
     Checks if a given username is valid and available.

     - API Endpoint: GET /auth/username-check
     - Parameter username: The username to check.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the UsernameCheckResonse object or an Error.
     */
    public static func checkUsername(_ username:String, handler:@escaping (Result<UsernameCheckResonse, Error>)->Void) {
        let urlString = baseURL + "auth/username-check"
        fetchData(LBQuery(urlString, queryParams: [URLQueryItem(name: "username", value: username)]), handler: handler)
    }
}
