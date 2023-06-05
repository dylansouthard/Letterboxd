//
//  ContributorRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /contributor/{id} ===
    
    public static func fetchContributor(_ id:String, handler:@escaping(Result<Contributor, Error>)->Void) {
        let urlString = baseURL + "contributor/\(id)"
        let query = LBQuery(urlString)
        fetchData(query, handler: handler)
    }
    
    //MARK: - === GET /contributor/{id}/contributions ===
    
    public static func fetchContributions(
        for id:String,
        params:LBParams.Contributions? = nil,
        forceAuth:Bool = false,
        handler:@escaping(Result<FilmContributionsResponse, Error>)->Void
    ) {
        let urlString = baseURL + "contributor/\(id)/contributions"
        
        let query = LBQuery(urlString, queryParams:params?.urlQueryItems ?? [])
        
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
}
