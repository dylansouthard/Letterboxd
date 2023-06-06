//
//  ListRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation
extension Letterboxd {
    
    //MARK: - === GET /lists ===
    /**
    Retrieves a list of lists.

    - API Endpoint: GET /lists
    - Parameter params: Optional parameters to filter the returned list of lists. If none are provided, all lists are returned.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ListResponse object or an Error.
    */
    public static func fetchLists(params:LBParams.Lists? = nil, forceAuth:Bool = false, handler:@escaping(Result<ListResponse, Error>)->Void) {
        
        let urlString = baseURL + "lists"
        
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //TODO: - === POST /lists ===
    //TODO: - === PATCH /lists ===
    
    //MARK: - === GET /lists/topics ===
    /**
    Retrieves a list of featured topics for lists.

    - API Endpoint: GET /lists/topics
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the TopicsResponse object or an Error.
    */
    public static func fetchFeaturedTopics(handler:@escaping(Result<TopicsResponse, Error>)->Void) {
        let urlString = baseURL + "lists/topics"
        fetchData(LBQuery(urlString), handler: handler)
    }
    
    //MARK: - === GET /list/{id} ===
    /**
    Retrieves a specific list.

    - API Endpoint: GET /list/{id}
    - Parameter id: The unique identifier of the list.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the List object or an Error.
    */

    public static func fetchList(_ id:String, handler:@escaping(Result<List, Error>)->Void) {
        let urlString = baseURL + "list/\(id)"
        fetchData(LBQuery(urlString), handler: handler)
    }
    
    //TODO: - PATCH /list/{id}
    //TODO: - DELETE /list/{id}
    
    //MARK: - === GET /list/{id}/comments ===
    /**
    Retrieves comments for a specific list.

    - API Endpoint: GET /list/{id}/comments
    - Parameter id: The unique identifier of the list.
    - Parameter params: Optional parameters to filter the returned list of comments. If none are provided, all comments are returned.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ListCommentsResponse object or an Error.
    */
    public static func fetchComments(forList id:String, params:LBParams.Comments? = nil, handler:@escaping(Result<ListCommentsResponse, Error>)->Void) {
        
        let urlString = baseURL + "list/\(id)/comments"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler)
        
    }
    
    //TODO: - POST /list/{id}/comments
    
    
    //MARK: - === GET /list/{id}/entries ===
    /**
    Retrieves entries for a specific list.

    - API Endpoint: GET /list/{id}/entries
    - Parameter id: The unique identifier of the list.
    - Parameter params: Optional parameters to filter the returned list of entries. If none are provided, all entries are returned.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ListEntriesResponse object or an Error.
    */
    public static func fetchEntries(forList id:String, params:LBParams.ListEntries? = nil, forceAuth:Bool = false, handler:@escaping(Result<ListEntriesResponse, Error>)->Void) {
        
        let urlString = baseURL + "list/\(id)/entries"
        
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /list/{id}/me ===
    /**
    Retrieves the authenticated user's relationship to a specific list.

    - API Endpoint: GET /list/{id}/me
    - Parameter id: The unique identifier of the list.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ListRelationship object or an Error.
    */
    public static func fetchMyRelationship(toList id:String, handler:@escaping(Result<ListRelationship, Error>)->Void) {
        
        let urlString = baseURL + "list/\(id)/me"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
    
    //TODO: - === PATCH /list/{id}/me ===
    //TODO: - === POST /list/{id}/report ===
    
    
    //MARK: - === GET /list/{id}/statistics ===
    /**
    Retrieves statistics for a specific list.

    - API Endpoint: GET /list/{id}/statistics
    - Parameter id: The unique identifier of the list.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ListStatistics object or an Error.
    */
    public static func fetchStatistics(forList id:String, handler:@escaping(Result<ListStatistics, Error>)->Void) {
        
        let urlString = baseURL + "list/\(id)/statistics"
        
        fetchData(LBQuery(urlString), handler: handler)
    }
}


