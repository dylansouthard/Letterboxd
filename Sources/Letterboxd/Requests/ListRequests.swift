//
//  ListRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation
extension Letterboxd {
    
    //MARK: - === GET /lists ===
    public static func fetchLists(params:LBParams.Lists? = nil, forceAuth:Bool = false, handler:@escaping(Result<ListResponse, Error>)->Void) {
        
        let urlString = baseURL + "lists"
        
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //TODO: - === POST /lists ===
    //TODO: - === PATCH /lists ===
    
    //MARK: - === GET /lists/topics ===
    public static func fetchFeaturedTopics(handler:@escaping(Result<TopicsResponse, Error>)->Void) {
        let urlString = baseURL + "lists/topics"
        fetchData(LBQuery(urlString), handler: handler)
    }
    
    //MARK: - === GET /list/{id} ===
    public static func fetchList(_ id:String, handler:@escaping(Result<List, Error>)->Void) {
        let urlString = baseURL + "list/\(id)"
        fetchData(LBQuery(urlString), handler: handler)
    }
    
    //TODO: - PATCH /list/{id}
    //TODO: - DELETE /list/{id}
    
    //MARK: - === GET /list/{id}/comments ===
    public static func fetchComments(forList id:String, params:LBParams.Comments? = nil, handler:@escaping(Result<ListCommentsResponse, Error>)->Void) {
        
        let urlString = baseURL + "list/\(id)/comments"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler)
        
    }
    
    //TODO: - POST /list/{id}/comments
    
    
    //MARK: - === GET /list/{id}/entries ===
    public static func fetchEntries(forList id:String, params:LBParams.ListEntries? = nil, forceAuth:Bool = false, handler:@escaping(Result<ListEntriesResponse, Error>)->Void) {
        
        let urlString = baseURL + "list/\(id)/entries"
        
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /list/{id}/me ===
    public static func fetchMyRelationship(toList id:String, handler:@escaping(Result<ListRelationship, Error>)->Void) {
        
        let urlString = baseURL + "list/\(id)/me"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
    
    //TODO: - === PATCH /list/{id}/me ===
    //TODO: - === POST /list/{id}/report ===
    
    
    //MARK: - === GET /list/{id}/statistics ===
    public static func fetchStatistics(forList id:String, handler:@escaping(Result<ListStatistics, Error>)->Void) {
        
        let urlString = baseURL + "list/\(id)/statistics"
        
        fetchData(LBQuery(urlString), handler: handler)
    }
}
