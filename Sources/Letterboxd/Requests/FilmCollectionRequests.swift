//
//  FilmCollectionRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension Letterboxd {
    //MARK: - === GET /film-collection/{id} ===
        
    /**
     Retrieves the details of a specific film collection.

     - API Endpoint: GET /film-collection/{id}
     - Parameter id: The unique identifier of the film collection.
     - Parameter params: Optional parameters to filter the returned collection. If none are provided, all films in the collection are returned.
     - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmCollection object or an Error.
     */
    public static func fetchFilmCollection(
        _ id:String,
        params:LBParams.FilmCollection? = nil,
        forceAuth:Bool = false,
        handler:@escaping(Result<FilmCollection, Error>)->Void
    ) {
        let urlString = baseURL + "film-collection/\(id)"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler:handler, requiresAuth:forceAuth)
    }
}
