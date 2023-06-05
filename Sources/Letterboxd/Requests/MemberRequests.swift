//
//  MemberRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-02.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /members ===
    
    public static func fetchMembers(
        params:LBParams.Members? = nil,
        forceAuth:Bool = false,
        handler:@escaping(Result<MembersResponse, Error>)->Void
    ) {
        let urlString = baseURL + "members"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /members/pronouns ===
    public static func fetchPronouns(handler:@escaping(Result<PronounsResponse, Error>)->Void) {
        let urlString = baseURL + "members/pronouns"
        fetchData(LBQuery(urlString), handler: handler)
    }
    
    //TODO: === POST /members/register ===
    
    //MARK: - === GET /member/{id} ===
    public static func fetchMember(_ id:String, forceAuth:Bool = false, handler:@escaping(Result<Member, Error>)->Void) {
        let urlString = baseURL + "member/\(id)"
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /member/{id}/activity ===
    public static func fetchActivity(forMember id:String, params:LBParams.Activity? = nil, forceAuth:Bool = false, handler:@escaping(Result<ActivityResponse, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/activity"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /member/{id}/list-tags-2 ===
    public static func fetchListTags(forMember id:String, input:String? = nil, handler:@escaping(Result<MemberTagsResponse, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/list-tags-2"
        let query = LBQuery(urlString, queryParams: input != nil ? [URLQueryItem(name: "input", value: input)] : [])
        fetchData(query, handler: handler)
    }
    
    //MARK: - === GET /member/{id}/log-entry-tags ===
    public static func fetchLogEntryTags(forMember id:String, input:String? = nil, handler:@escaping(Result<MemberTagsResponse, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/log-entry-tags"
        let query = LBQuery(urlString, queryParams: input != nil ? [URLQueryItem(name: "input", value: input)] : [])
        fetchData(query, handler: handler)
    }
    
    //MARK: - === GET /member/{id}/me ===
    public static func fetchMyRelationship(toMember id:String, handler:@escaping(Result<MemberRelationship, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/me"
      
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
    
    //TODO: === PATCH /member/{id}/me ===
    
    //TODO: === POST /member/{id}/report ===
    
    //MARK: - === GET /member/{id}/statistics ===
    public static func fetchStatistics(forMember id:String, forceAuth:Bool = false, handler:@escaping(Result<MemberStatistics, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/statistics"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /member/{id}/watchlist ===
    public static func fetchWatchlist(forMember id:String, params:LBParams.Watchlist? = nil, forceAuth:Bool = false, handler:@escaping(Result<FilmsResponse, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/watchlist"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
}
