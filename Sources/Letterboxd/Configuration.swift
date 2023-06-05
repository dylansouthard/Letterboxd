//
//  LetterboxdQuery.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-24.
//

import Foundation

public class Letterboxd {
    static var tokenManager = LetterboxdTokenManager()
    
    //MARK: - === Keys ===
    
    static var apiKey:String?
    
    static var apiSecret:String?
    
    static var baseURL:String = "https://api.letterboxd.com/api/v0/"
    
    public static func configure(apiKey:String, apiSecret:String) {
        Letterboxd.apiKey = apiKey
        Letterboxd.apiSecret = apiSecret
    }

}

