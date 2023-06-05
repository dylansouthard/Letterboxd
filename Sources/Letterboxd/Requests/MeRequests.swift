//
//  MeRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /me ===
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
