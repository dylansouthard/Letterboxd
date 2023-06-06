//
//  ContributorRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /contributor/{id} ===

    /**
     Retrieves the details of a specific contributor.

     - API Endpoint: GET /contributor/{id}
     - Parameter id: The unique identifier of the contributor.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the Contributor object or an Error.
     */
    public static func fetchContributor(_ id:String, handler:@escaping(Result<Contributor, Error>)->Void) {
        let urlString = baseURL + "contributor/\(id)"
        let query = LBQuery(urlString)
        fetchData(query, handler: handler)
    }

    //MARK: - === GET /contributor/{id}/contributions ===

    /**
     Retrieves a list of contributions by a specific contributor.

     - API Endpoint: GET /contributor/{id}/contributions
     - Parameter id: The unique identifier of the contributor.
     - Parameter params: Optional parameters to filter the returned list of contributions. If none are provided, all contributions by the contributor are returned.
     - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmContributionsResponse object or an Error.
     */
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

