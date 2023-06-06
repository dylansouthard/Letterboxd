//
//  StoryRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-05.
//

import Foundation

extension Letterboxd {
    //MARK: - === GET /stories ===
    /**
    Retrieves stories.

    - API Endpoint: GET /stories
    - Parameter params: Optional parameters to filter the returned list of stories. If none are provided, all stories are returned.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the StoriesResponse object or an Error.
    */
    public static func fetchStories(params:LBParams.Stories? = nil, forceAuth:Bool = false, handler:@escaping(Result<StoriesResponse, Error>)->Void) {
        let urlString = baseURL + "stories"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
}
