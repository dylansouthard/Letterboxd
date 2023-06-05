//
//  StoryRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-05.
//

import Foundation

extension Letterboxd {
    //MARK: - === /stories ===
    public static func fetchStories(params:LBParams.Stories? = nil, forceAuth:Bool = false, handler:@escaping(Result<StoriesResponse, Error>)->Void) {
        let urlString = baseURL + "stories"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
}
