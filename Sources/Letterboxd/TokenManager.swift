//
//  LetterboxdKeychainManager.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-24.
//

import Foundation
import KeychainAccess

// Class to manage tokens in Letterboxd
class LetterboxdTokenManager {

    // Singleton instance
    static let shared = LetterboxdTokenManager()
    
   //MARK: - =============== VARIABLES ===============
    
    
    //MARK: - === UTILITY VARS ===
    
    private let dateFormatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ssZ")
    private let urlString = Letterboxd.baseURL + "auth/token"
    private let keychain = Keychain(service: "com.ihounokyaku.letterboxd")
    
    //MARK: - === TOKEN VARS ===
    
    // Access token for Letterboxd API
    var accessToken: String? {
        get { return keychain["letterboxd_access_token"] }
        set { keychain["letterboxd_access_token"] = newValue }
    }
    
    // Refresh token for Letterboxd API
    var refreshToken:String? {
        get { return keychain["letterboxd_refresh_token"] }
        set { keychain["letterboxd_refresh_token"] = newValue }
    }
    
    // Expiry time of the token
    var expiryTime:Date? {
        get {
            guard let dateString = keychain["letterboxd_token_expiry"] else {return nil}
            return dateFormatter.date(from: dateString)
        }
        
        set {
            guard let date = newValue else {
                keychain["letterboxd_token_expiry"] = nil
                return
            }
            keychain["letterboxd_token_expiry"] = dateFormatter.string(from:date)
        }
    }
    
    // Check if the token is expired
    private var tokenExpired:Bool {
        guard let expiryTime = expiryTime else {
                    return true
                }
                return Date() >= expiryTime
    }
    
    // Check if the token is valid
    private var tokenValid:Bool {!(accessToken == nil || tokenExpired)}
    
    
    
    
    //MARK: - =============== FUNCTIONS ===============
    
    //MARK: - === GENERATE/REFRESH TOKEN ===
    
    // ----------------------------------------------------------------------------------------------------------------------------------------
    
    // Function to generate the authentication token using username and password
    func generateAuthToken(username:String, password:String, onComplete:@escaping (Result<Void, Error>)->Void = {result in}) {
        
        let bodyParams: [String: String] = [
            "grant_type": "password",
            "username": username,
            "password": password
        ]
        
        fetchToken(bodyParams: bodyParams, onComplete: onComplete)
    }
    
    // ----------------------------------------------------------------------------------------------------------------------------------------
    
    // Function to refresh the authentication token
    func refreshAuthToken(_ onComplete:@escaping (Result<Void, Error>)->Void = {result in}) {
        guard let currentRefreshToken = refreshToken else {
            onComplete(.failure(LetterboxdError.noToken))
                return
            }

            let bodyParams: [String: String] = [
                "grant_type": "refresh_token",
                "refresh_token": currentRefreshToken
            ]
        
        fetchToken(bodyParams: bodyParams, onComplete: onComplete)
    }
    
    // ----------------------------------------------------------------------------------------------------------------------------------------
    
    // Function to fetch the token using body parameters
    func fetchToken(bodyParams:[String:String], onComplete:@escaping (Result<Void, Error>)->Void = {result in}) {
        
        Letterboxd.sendRequest(Letterboxd.LBQuery(urlString, method: .post, bodyParams: bodyParams), requiresAuth:false, isTokenRequest: true) {result in
            switch result {
            case .success(let (d, _)):
                do {
                    if let data = d, let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        DispatchQueue.main.async {
                            self.accessToken = json["access_token"] as? String
                            self.refreshToken = json["refresh_token"] as? String
                            
                            if let et = json["expires_in"] as? TimeInterval {
                                self.expiryTime = Date().addingTimeInterval(et)
                            }
                            onComplete(.success(()))
                        }
                    }
                } catch {
                    onComplete(.failure(error))
                }
            case .failure(let error):
                onComplete(.failure(error))
                return
            }
        }
    }
    
    
    
    //MARK: - === CHECK TOKEN ===
    
    // Function to check the validity of the token and refresh if needed
    func checkToken(_ action:@escaping (Result<String, Error>)->Void) {
        
        if tokenValid {
            action(.success(accessToken!))
            return
        }
        
        if tokenExpired {
            refreshAuthToken() { [weak self] result in
                switch result {
                case .success:
                    guard let token = self?.accessToken else {
                        action(.failure(LetterboxdError.noToken))
                        return
                    }
                    action(.success(token))
                case .failure(let error):
                    action(.failure(error))
                }
            }
        }
    }
}



