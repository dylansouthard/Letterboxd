//
//  SearchRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /search ===
    public static func search(
        _ query: String,
        params:LBParams.Search? = nil,
        handler: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        
        let urlString = baseURL + "searchbb"

        let query = LBQuery(urlString, queryParams: [URLQueryItem.input(query)] + (params?.urlQueryItems ?? []))

        fetchData(query, handler: handler)
    }
}
