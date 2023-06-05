//
//  FilmCollectionRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension Letterboxd {
    //MARK: - === GET /film-collection/{id} ===
    
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
