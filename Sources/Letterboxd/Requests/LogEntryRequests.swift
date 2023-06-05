//
//  LogEntryRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /log-entries ===
    
    public static func fetchLogEntries(params:LBParams.LogEntries? = nil, forceAuth:Bool = false, handler:@escaping(Result<LogEntriesResponse, Error>)->Void) {
        let urlString = baseURL + "log-entries"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    //MARK: - === GET /log-entry{id} ===
    
    public static func fetchLogEntry(_ id:String, forceAuth:Bool = false, handler:@escaping(Result<LogEntry, Error>)->Void) {
        let urlString = baseURL + "log-entry/\(id)"
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: forceAuth)
    }
    
    //TODO: === PATCH /log-entry/{id} ===
    
    //TODO: === DELETE /log-entry/{id} ===
    
    //MARK: - === GET /log-entry/{id}/comments ===
    public static func fetchComments(forLogEntry id:String, params:LBParams.Comments? = nil, forceAuth:Bool = false, handler:@escaping(Result<ReviewCommentsResponse, Error>)->Void) {
        let urlString = baseURL + "log-entry/\(id)/comments"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /log-entry/{id}/me ===
    public static func fetchMyRelationship(toLogEntry id:String, handler:@escaping(Result<ReviewRelationship, Error>)->Void) {
        
        let urlString = baseURL + "log-entry/\(id)/me"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
    
    //TODO: ===  PATCH /log-entry/{id}/me  ===
    //TODO: ===  POST /log-entry/{id}/report  ===
    
    //MARK: - === GET /log-entry/{id}/statistics ===
    public static func fetchStatistics(forLogEntry id:String, handler:@escaping(Result<ReviewStatistics, Error>)->Void) {
        
        let urlString = baseURL + "log-entry/\(id)/statistics"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
}
