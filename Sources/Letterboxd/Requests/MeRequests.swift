//
//  MeRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /me ===
    /**
    Retrieves the authenticated user's details.

    - API Endpoint: GET /me
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the MemberAccount object or an Error.
    */
    public static func fetchMyDetails(handler:@escaping(Result<MemberAccount, Error>)->Void) {
        
        let urlString = baseURL + "me"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
    
    //TODO: === PATCH /me ===
    
    //TODO: === GET /me/check-tag ===
    
    //TODO: === DELETE /me/delete-tag ===
    
    //TODO: === POST /me/deregister-push-notifications ===
    
    //TODO: === POST /me/disable ===
    
    //TODO: === POST /me/register-push-notifications ===
    
    //TODO: === PATCH /me/update-tag ===
    
    //TODO: === POST /me/validation-request ===
    
    
}
