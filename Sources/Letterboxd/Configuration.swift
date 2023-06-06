//
//  LetterboxdQuery.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-24.
//

import Foundation

public class Letterboxd {
    static var tokenManager:LetterboxdTokenManager?
    
    //MARK: - === Keys ===
    
    static var apiKey:String?
    
    static var apiSecret:String?
    
    static var baseURL:String = "https://api.letterboxd.com/api/v0/"
    
    /**
     Checks if the user is logged in by checking if an access token exists.
     
     - Return: A Boolean value indicating if the user is logged in.
     */
    public static var isLoggedIn:Bool {return tokenManager?.accessToken != nil}
    
    /**
     Configures the API keys for the application. Must be implemented before any requests are made.
     
     - Parameters:
        - apiKey: The application's API key.
        - apiSecret: The application's API secret.
        - keychainService: The service name for keychain storage used to store the access and refresh tokens. This must be unique for your application.
     */
    public static func configure(apiKey:String, apiSecret:String, keychainService:String) {
        Letterboxd.apiKey = apiKey
        Letterboxd.apiSecret = apiSecret
        self.tokenManager = LetterboxdTokenManager(service: keychainService)
    }
    
    /**
     Logs the user out by removing the existing access token.
     */
    public static func logout() { tokenManager?.removeToken()}
    
}

