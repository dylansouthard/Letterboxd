//
//  LogEntryRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /log-entries ===
    /**
    Retrieves a list of log entries.

    - API Endpoint: GET /log-entries
    - Parameter params: Optional parameters to filter the returned list of log entries. If none are provided, all log entries are returned.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the LogEntriesResponse object or an Error.
    */
    public static func fetchLogEntries(params:LBParams.LogEntries? = nil, forceAuth:Bool = false, handler:@escaping(Result<LogEntriesResponse, Error>)->Void) {
        let urlString = baseURL + "log-entries"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    
    //MARK: - === GET /log-entry{id} ===
    /**
    Retrieves a specific log entry.

    - API Endpoint: GET /log-entry/{id}
    - Parameter id: The unique identifier of the log entry.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the LogEntry object or an Error.
    */
    public static func fetchLogEntry(_ id:String, forceAuth:Bool = false, handler:@escaping(Result<LogEntry, Error>)->Void) {
        let urlString = baseURL + "log-entry/\(id)"
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: forceAuth)
    }
    
    //TODO: === PATCH /log-entry/{id} ===
    
    //TODO: === DELETE /log-entry/{id} ===
    
    //MARK: - === GET /log-entry/{id}/comments ===
    /**
    Retrieves comments for a specific log entry.

    - API Endpoint: GET /log-entry/{id}/comments
    - Parameter id: The unique identifier of the log entry.
    - Parameter params: Optional parameters to filter the returned list of comments. If none are provided, all comments are returned.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ReviewCommentsResponse object or an Error.
    */
    public static func fetchComments(forLogEntry id:String, params:LBParams.Comments? = nil, forceAuth:Bool = false, handler:@escaping(Result<ReviewCommentsResponse, Error>)->Void) {
        let urlString = baseURL + "log-entry/\(id)/comments"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /log-entry/{id}/me ===
    /**
    Retrieves the authenticated user's relationship to a specific log entry.

    - API Endpoint: GET /log-entry/{id}/me
    - Parameter id: The unique identifier of the log entry.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ReviewRelationship object or an Error.
    */
    public static func fetchMyRelationship(toLogEntry id:String, handler:@escaping(Result<ReviewRelationship, Error>)->Void) {
        
        let urlString = baseURL + "log-entry/\(id)/me"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
    
    //TODO: ===  PATCH /log-entry/{id}/me  ===
    //TODO: ===  POST /log-entry/{id}/report  ===
    
    //MARK: - === GET /log-entry/{id}/statistics ===
    /**
    Retrieves statistics for a specific log entry.

    - API Endpoint: GET /log-entry/{id}/statistics
    - Parameter id: The unique identifier of the log entry.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ReviewStatistics object or an Error.
    */
    public static func fetchStatistics(forLogEntry id:String, handler:@escaping(Result<ReviewStatistics, Error>)->Void) {
        
        let urlString = baseURL + "log-entry/\(id)/statistics"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
}
