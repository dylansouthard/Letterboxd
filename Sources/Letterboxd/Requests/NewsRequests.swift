//
//  News.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-04.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /news ===
    /**
    Retrieves news.

    - API Endpoint: GET /news
    - Parameter pagination: Optional pagination parameters to control the range of news returned.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the NewsResponse object or an Error.
    */
    public static func fetchNews(pagination:LBParams.Pagination? = nil,handler:@escaping(Result<NewsResponse, Error>)->Void) {
        let urlString = baseURL + "news"
        let query = LBQuery(urlString, queryParams: pagination?.urlQueryItems ?? [])
        fetchData(query, handler: handler)
    }
    
}
