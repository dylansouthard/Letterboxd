//
//  FilmRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension Letterboxd {

    
    //MARK: - === GET /films ===
    
    public static func fetchFilms(
        params:LBParams.Films? = nil,
        forceAuth:Bool = false,
        handler:@escaping(Result<FilmsResponse, Error>)->Void
    ) {
        let urlString = baseURL + "films"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler: handler, requiresAuth: forceAuth)
    }
    
    //MARK: - === GET /films/countries ===
    public static func fetchAllCountries(handler:@escaping(Result<CountriesResponse, Error>)->Void) {
        let urlString = baseURL + "films/countries"
        fetchData(LBQuery(urlString), handler:handler)
    }
    
    //MARK: - === GET /films/film-services ===
    public static func fetchAllFilmServices(handler:@escaping(Result<FilmServicesResponse, Error>)->Void) {
        let urlString = baseURL + "films/film-services"
        fetchData(LBQuery(urlString), handler:handler)
    }
    
    //MARK: - === GET /films/genres ===
    public static func fetchAllGenres(handler:@escaping(Result<GenresResponse, Error>)->Void) {
        let urlString = baseURL + "films/genres"
        fetchData(LBQuery(urlString), handler:handler)
    }
    
    //MARK: - === GET /films/languages ===
    public static func fetchAllLanguages(handler:@escaping(Result<LanguagesResponse, Error>)->Void) {
        let urlString = baseURL + "films/languages"
        fetchData(LBQuery(urlString), handler:handler)
    }
    
    //MARK: - === GET /film/{id} ===
    public static func fetchFilm(_ id:String, member:String?, handler:@escaping(Result<Film, Error>)->Void) {
        let urlString = baseURL + "film/\(id)"
        let query = LBQuery(urlString, queryParams: URLQueryItem.array(fromString: member, named: "member"))
        fetchData(query, handler:handler)
    }
    
    //MARK: - === GET /film/{id}/friends ===
    public static func fetchFriendsRelationship(toFilm id:String, handler:@escaping(Result<FilmRelationshipResults, Error>)->Void) {
        let urlString = baseURL + "film/\(id)/friends"
        fetchData(LBQuery(urlString), handler:handler)
    }
    
    //MARK: - === GET /film/{id}/me ===
    public static func fetchMyRelationship(toFilm id:String, handler:@escaping(Result<FilmRelationship, Error>)->Void) {
        let urlString = baseURL + "film/\(id)/me"
        fetchData(LBQuery(urlString), handler:handler, requiresAuth: true)
    }
    
    //MARK: - === GET /film/{id}/members ===
    public static func fetchMembers(relatedToFilm id:String, params:LBParams.FilmMemberRelationship? = nil, forceAuth:Bool = false, handler:@escaping(Result<FilmRelationship, Error>)->Void) {
        
        let urlString = baseURL + "film/\(id)/me"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler:handler, requiresAuth: forceAuth)
        
    }
    
    //TODO: === POST /film/{id}/report ===
    
    //MARK: - === GET /film/{id}/statistics ===
    public static func fetchStatistics(forFilm id:String, member:String? = nil, handler:@escaping(Result<FilmStatistics, Error>)->Void) {
        let urlString = baseURL + "film/\(id)/statistics"
        let params = (URLQueryItem.array(fromString: member, named: "member"))
        fetchData(LBQuery(urlString, queryParams: params), handler:handler)
    }
}
