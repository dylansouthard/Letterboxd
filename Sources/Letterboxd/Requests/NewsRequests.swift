//
//  News.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-04.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /news ===
    public static func fetchNews(pagination:LBParams.Pagination? = nil,handler:@escaping(Result<NewsResponse, Error>)->Void) {
        let urlString = baseURL + "news"
        let query = LBQuery(urlString, queryParams: pagination?.urlQueryItems ?? [])
        fetchData(query, handler: handler)
    }
    
}
