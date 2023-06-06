//
//  FilmRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension Letterboxd {

    
    //MARK: - === GET /films ===

    /**
     Retrieves a list of films.

     - API Endpoint: GET /films
     - Parameter params: Optional parameters to filter the returned list of films. If none are provided, all films are returned.
     - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmsResponse object or an Error.
     */
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
    /**
     Retrieves a list of all film countries.

     - API Endpoint: GET /films/countries
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the CountriesResponse object or an Error.
     */
    public static func fetchAllCountries(handler:@escaping(Result<CountriesResponse, Error>)->Void) {
        let urlString = baseURL + "films/countries"
        fetchData(LBQuery(urlString), handler:handler)
    }

    //MARK: - === GET /films/film-services ===
    /**
     Retrieves a list of all film services.

     - API Endpoint: GET /films/film-services
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmServicesResponse object or an Error.
     */
    public static func fetchAllFilmServices(handler:@escaping(Result<FilmServicesResponse, Error>)->Void) {
        let urlString = baseURL + "films/film-services"
        fetchData(LBQuery(urlString), handler:handler)
    }

    //MARK: - === GET /films/genres ===
    /**
     Retrieves a list of all film genres.

     - API Endpoint: GET /films/genres
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the GenresResponse object or an Error.
     */
    public static func fetchAllGenres(handler:@escaping(Result<GenresResponse, Error>)->Void) {
        let urlString = baseURL + "films/genres"
        fetchData(LBQuery(urlString), handler:handler)
    }

    //MARK: - === GET /films/languages ===
    /**
     Retrieves a list of all film languages.

     - API Endpoint: GET /films/languages
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the LanguagesResponse object or an Error.
     */
    public static func fetchAllLanguages(handler:@escaping(Result<LanguagesResponse, Error>)->Void) {
        let urlString = baseURL + "films/languages"
        fetchData(LBQuery(urlString), handler:handler)
    }

    //MARK: - === GET /film/{id} ===
    /**
     Retrieves the details of a specific film.

     - API Endpoint: GET /film/{id}
     - Parameter id: The unique identifier of the film.
     - Parameter member: The unique identifier of the member. If provided, it returns the member's relationship to the film.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the Film object or an Error.
     */
    public static func fetchFilm(_ id:String, member:String?, handler:@escaping(Result<Film, Error>)->Void) {
        let urlString = baseURL + "film/\(id)"
        let query = LBQuery(urlString, queryParams: URLQueryItem.array(fromString: member, named: "member"))
        fetchData(query, handler:handler)
    }

    //MARK: - === GET /film/{id}/friends ===
    /**
     Retrieves the friends' relationships to a specific film.

     - API Endpoint: GET /film/{id}/friends
     - Parameter id: The unique identifier of the film.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmRelationshipResults object or an Error.
     */
    public static func fetchFriendsRelationship(toFilm id:String, handler:@escaping(Result<FilmRelationshipResults, Error>)->Void) {
        let urlString = baseURL + "film/\(id)/friends"
        fetchData(LBQuery(urlString), handler:handler)
    }

    //MARK: - === GET /film/{id}/me ===
    /**
     Retrieves the authenticated user's relationship to a specific film.

     - API Endpoint: GET /film/{id}/me
     - Parameter id: The unique identifier of the film.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmRelationship object or an Error.
     */
    public static func fetchMyRelationship(toFilm id:String, handler:@escaping(Result<FilmRelationship, Error>)->Void) {
        let urlString = baseURL + "film/\(id)/me"
        fetchData(LBQuery(urlString), handler:handler, requiresAuth: true)
    }

    //MARK: - === GET /film/{id}/members ===
    /**
     Retrieves the members' relationships to a specific film.

     - API Endpoint: GET /film/{id}/members
     - Parameter id: The unique identifier of the film.
     - Parameter params: Optional parameters to filter the returned list of member relationships. If none are provided, all member relationships to the film are returned.
     - Parameter forceAuth: A Boolean value indicating whether to force an authenticated request. Defaults to false.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmRelationship object or an Error.
     */
    public static func fetchMembers(relatedToFilm id:String, params:LBParams.FilmMemberRelationship? = nil, forceAuth:Bool = false, handler:@escaping(Result<FilmRelationship, Error>)->Void) {
        let urlString = baseURL + "film/\(id)/members"
        let query = LBQuery(urlString, queryParams: params?.urlQueryItems ?? [])
        fetchData(query, handler:handler, requiresAuth: forceAuth)
    }

    //MARK: - === GET /film/{id}/statistics ===
    /**
     Retrieves the statistics for a specific film.

     - API Endpoint: GET /film/{id}/statistics
     - Parameter id: The unique identifier of the film.
     - Parameter member: The unique identifier of the member. If provided, it returns the member's statistics related to the film.
     - Parameter handler: The closure to be invoked when the request is complete. It contains a result type that represents either a successful request containing the FilmStatistics object or an Error.
     */
    public static func fetchStatistics(forFilm id:String, member:String? = nil, handler:@escaping(Result<FilmStatistics, Error>)->Void) {
        let urlString = baseURL + "film/\(id)/statistics"
        let params = (URLQueryItem.array(fromString: member, named: "member"))
        fetchData(LBQuery(urlString, queryParams: params), handler:handler)
    }
}
