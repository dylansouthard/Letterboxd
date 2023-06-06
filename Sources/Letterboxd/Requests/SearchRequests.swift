//
//  SearchRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /search ===
    /**
    Performs a search based on a query.

    - API Endpoint: GET /search
    - Parameter query: The search query.
    - Parameter params: Optional parameters to filter the search results.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the SearchResponse object or an Error.
    */
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
