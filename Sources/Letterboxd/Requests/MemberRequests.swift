//
//  MemberRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-02.
//

import Foundation

extension Letterboxd {
    
    //MARK: - === GET /members ===
    /**
    Retrieves a list of members.

    - API Endpoint: GET /members
    - Parameter params: Optional parameters to filter the returned list of members. If none are provided, all members are returned.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the MembersResponse object or an Error.
    */
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
    /**
    Retrieves a list of pronouns.

    - API Endpoint: GET /members/pronouns
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the PronounsResponse object or an Error.
    */
    public static func fetchPronouns(handler:@escaping(Result<PronounsResponse, Error>)->Void) {
        let urlString = baseURL + "members/pronouns"
        fetchData(LBQuery(urlString), handler: handler)
    }
    
    //TODO: === POST /members/register ===
    
    //MARK: - === GET /member/{id} ===
    /**
    Retrieves a specific member.

    - API Endpoint: GET /member/{id}
    - Parameter id: The unique identifier of the member.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the Member object or an Error.
    */
    public static func fetchMember(_ id:String, forceAuth:Bool = false, handler:@escaping(Result<Member, Error>)->Void) {
        let urlString = baseURL + "member/\(id)"
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: forceAuth)
    }
    
    
    //MARK: - === GET /member/{id}/activity ===
    /**
    Retrieves activity for a specific member.

    - API Endpoint: GET /member/{id}/activity
    - Parameter id: The unique identifier of the member.
    - Parameter params: Optional parameters to filter the returned activity. If none are provided, all activity is returned.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the ActivityResponse object or an Error.
    */
    public static func fetchActivity(forMember id:String, params:LBParams.Activity? = nil, forceAuth:Bool = false, handler:@escaping(Result<ActivityResponse, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/activity"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    
    //MARK: - === GET /member/{id}/list-tags-2 ===
    /**
    Retrieves list tags for a specific member.

    - API Endpoint: GET /member/{id}/list-tags-2
    - Parameter id: The unique identifier of the member.
    - Parameter input: Optional input to filter the returned list of tags. If none is provided, all tags are returned.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the MemberTagsResponse object or an Error.
    */
    public static func fetchListTags(forMember id:String, input:String? = nil, handler:@escaping(Result<MemberTagsResponse, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/list-tags-2"
        let query = LBQuery(urlString, queryParams: input != nil ? [URLQueryItem(name: "input", value: input)] : [])
        fetchData(query, handler: handler)
    }
    
    
    //MARK: - === GET /member/{id}/log-entry-tags ===
    /**
    Retrieves log entry tags for a specific member.

    - API Endpoint: GET /member/{id}/log-entry-tags
    - Parameter id: The unique identifier of the member.
    - Parameter input: Optional input to filter the returned list of tags. If none is provided, all tags are returned.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the MemberTagsResponse object or an Error.
    */
    public static func fetchLogEntryTags(forMember id:String, input:String? = nil, handler:@escaping(Result<MemberTagsResponse, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/log-entry-tags"
        let query = LBQuery(urlString, queryParams: input != nil ? [URLQueryItem(name: "input", value: input)] : [])
        fetchData(query, handler: handler)
    }
    
    
    //MARK: - === GET /member/{id}/me ===
    /**
    Retrieves the authenticated user's relationship to a specific member.

    - API Endpoint: GET /member/{id}/me
    - Parameter id: The unique identifier of the member.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the MemberRelationship object or an Error.
    */    public static func fetchMyRelationship(toMember id:String, handler:@escaping(Result<MemberRelationship, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/me"
      
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: true)
    }
    
    //TODO: === PATCH /member/{id}/me ===
    
    //TODO: === POST /member/{id}/report ===
    
    //MARK: - === GET /member/{id}/statistics ===
    /**
    Retrieves statistics for a specific member.

    - API Endpoint: GET /member/{id}/statistics
    - Parameter id: The unique identifier of the member.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the MemberStatistics object or an Error.
    */
    public static func fetchStatistics(forMember id:String, forceAuth:Bool = false, handler:@escaping(Result<MemberStatistics, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/statistics"
        
        fetchData(LBQuery(urlString), handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /member/{id}/watchlist ===
    /**
    Retrieves the watchlist for a specific member.

    - API Endpoint: GET /member/{id}/watchlist
    - Parameter id: The unique identifier of the member.
    - Parameter params: Optional parameters to filter the returned watchlist. If none are provided, all watchlist items are returned.
    - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
    - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmsResponse object or an Error.
    */
    public static func fetchWatchlist(forMember id:String, params:LBParams.Watchlist? = nil, forceAuth:Bool = false, handler:@escaping(Result<FilmsResponse, Error>)->Void) {
        let urlString = baseURL + "member/\(id)/watchlist"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
}
