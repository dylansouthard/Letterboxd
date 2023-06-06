//
//  Film.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-30.
//

import Foundation
extension LBParams {

    public struct Films:LBParamConvertible {
        /// Specifies criteria for the films to retrieve.
            public var films:FilmParams = FilmParams()
            
            /// Defines the relationship with a member. Can be used to retrieve films connected to a particular member.
            public var member:FilmMemberRelationship?
            
            /// Specifies a tag. Retrieves films that are tagged with this.
            public var tag:Tag?
            
            /// Pagination settings for the retrieved list.
            public var pagination:Pagination = Pagination()
            
            /// Determines the sorting rule for the retrieved list.
            public var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return films.urlQueryItems + (member?.urlQueryItems ?? []) + (tag?.urlQueryItems ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
        }
        
        // Films
        /**
         Retrieves films based on specified criteria.

         - Parameter films: Specifies criteria for the films to retrieve.
         - Parameter member: Defines the relationship with a member. Can be used to retrieve films connected to a particular member.
         - Parameter tag: Specifies a tag. Retrieves films that are tagged with this.
         - Parameter pagination: Pagination settings for the retrieved list.
         - Parameter sortBy: Determines the sorting rule for the retrieved list.
         */
        public init(films: FilmParams = FilmParams(),
                    member: FilmMemberRelationship? = nil,
                    tag: Tag? = nil,
                    pagination: Pagination = Pagination(),
                    sortBy: SortRule? = nil) {
            self.films = films
            self.member = member
            self.tag = tag
            self.pagination = pagination
            self.sortBy = sortBy
        }
        
        public enum SortRule: String, Codable, LBParamType {
            
            case filmName = "FilmName"
            case dateLatestFirst = "DateLatestFirst"
            case dateEarliestFirst = "DateEarliestFirst"
            case releaseDateLatestFirst = "ReleaseDateLatestFirst"
            case releaseDateEarliestFirst = "ReleaseDateEarliestFirst"
            case authenticatedMemberRatingHighToLow = "AuthenticatedMemberRatingHighToLow"
            case authenticatedMemberRatingLowToHigh = "AuthenticatedMemberRatingLowToHigh"
            case authenticatedMemberBasedOnLiked = "AuthenticatedMemberBasedOnLiked"
            case authenticatedMemberRelatedToLiked = "AuthenticatedMemberRelatedToLiked"
            case memberRatingHighToLow = "MemberRatingHighToLow"
            case memberRatingLowToHigh = "MemberRatingLowToHigh"
            case averageRatingHighToLow = "AverageRatingHighToLow"
            case averageRatingLowToHigh = "AverageRatingLowToHigh"
            case ratingHighToLow = "RatingHighToLow"
            case ratingLowToHigh = "RatingLowToHigh"
            case filmDurationShortestFirst = "FilmDurationShortestFirst"
            case filmDurationLongestFirst = "FilmDurationLongestFirst"
            case bestMatch = "BestMatch"
            case filmPopularity = "FilmPopularity"
            case filmPopularityThisWeek = "FilmPopularityThisWeek"
            case filmPopularityThisMonth = "FilmPopularityThisMonth"
            case filmPopularityThisYear = "FilmPopularityThisYear"
            case filmPopularityWithFriends = "FilmPopularityWithFriends"
            case filmPopularityWithFriendsThisWeek = "FilmPopularityWithFriendsThisWeek"
            case filmPopularityWithFriendsThisMonth = "FilmPopularityWithFriendsThisMonth"
            case filmPopularityWithFriendsThisYear = "FilmPopularityWithFriendsThisYear"
            
            static var paramName: String = "sort"
            static let `default` = SortRule.filmPopularity
        }
    }
    
    //MARK: - =============== film/{id}/members ===============
    public struct FilmRelatedMembers:LBParamConvertible {
        
        /// Specifies the member and type of relationship.
        public var member:MemberRelationship?
        
        /// Pagination settings for the retrieved list.
        public var pagination:Pagination = Pagination()
        
        /// Determines the sorting rule for the retrieved list.
        public var sortBy:Members.SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return (member?.urlQueryItems ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam: sortBy)
        }
        
        // FilmRelatedMembers
        /**
         Retrieves members related to a specific film.

         - Parameter member: Specifies the member and type of relationship.
         - Parameter pagination: Pagination settings for the retrieved list.
         - Parameter sortBy: Determines the sorting rule for the retrieved list.
         */
        public init(member: MemberRelationship? = nil,
                    pagination: Pagination = Pagination(),
                    sortBy: Members.SortRule? = nil) {
            self.member = member
            self.pagination = pagination
            self.sortBy = sortBy
        }
    }
    
    //MARK: - =============== SHARED FILMS PARAMS ===============
    public struct FilmParams:LBParamConvertible {
        /// List of film IDs to search for.
        public var filmIDs:[String] = []
        
        /// Genre parameters for the films to search for.
        public var genre:Genre = Genre()
        
        /// Region parameters for the films to search for.
        public var region:Region = Region()
        
        /// Release date parameters for the films to search for.
        public var releaseDate:ReleaseDate = ReleaseDate()
        
        /// The film service to use for searching films.
        public var service:String?
        
        /// Additional filters to apply when searching for films.
        public var filters:[Filter] = []
        
        var urlQueryItems: [URLQueryItem] {
            return filmIDs.map{URLQueryItem(name: "filmId", value: $0)} + genre.urlQueryItems + region.urlQueryItems + releaseDate.urlQueryItems + URLQueryItem.array(fromString: service, named: "service") + filters.map{$0.asURLQueryItem}
        }
        
        // FilmParams
        /**
         Specifies criteria for filtering and searching for films.

         - Parameter filmIDs: List of film IDs to search for.
         - Parameter genre: Genre id for the films to search for.
         - Parameter region: Region parameters for the films to search for.
         - Parameter releaseDate: Release date parameters for the films to search for.
         - Parameter service: The film service to use for searching films.
         - Parameter filters: Additional filters to apply when searching for films.
         */
        public init(filmIDs: [String] = [],
                    genre: Genre = Genre(),
                    region: Region = Region(),
                    releaseDate: ReleaseDate = ReleaseDate(),
                    service: String? = nil,
                    filters: [Filter] = []) {
            self.filmIDs = filmIDs
            self.genre = genre
            self.region = region
            self.releaseDate = releaseDate
            self.service = service
            self.filters = filters
        }
        
        public enum Filter: String, Codable, LBParamType {
            case released = "Released"
            case notReleased = "NotReleased"
            case inWatchlist = "InWatchlist"
            case notInWatchlist = "NotInWatchlist"
            case logged = "Logged"
            case notLogged = "NotLogged"
            case rewatched = "Rewatched"
            case notRewatched = "NotRewatched"
            case reviewed = "Reviewed"
            case notReviewed = "NotReviewed"
            case owned = "Owned"
            case notOwned = "NotOwned"
            case customised = "Customised"
            case notCustomised = "NotCustomised"
            case rated = "Rated"
            case notRated = "NotRated"
            case liked = "Liked"
            case notLiked = "NotLiked"
            case watchedFromWatchlist = "WatchedFromWatchlist"
            case watched = "Watched"
            case notWatched = "NotWatched"
            case featureLength = "FeatureLength"
            case notFeatureLength = "NotFeatureLength"
            case fiction = "Fiction"
            case film = "Film"
            case TV = "TV"
            static var paramName: String{"where"}
        }
    }
    
    
    
    public struct FilmID {
        public let id:String
        public let externalType:ExternalFilmIDType?
        
        public enum ExternalFilmIDType:String {
            case tmdb
            case imdb
            
        }
        
        public init(_ id:String, externalType:ExternalFilmIDType? = nil) {
            self.id = id
            self.externalType = externalType
        }
        
        var asURLQueryItem:URLQueryItem {
            var typeString = ""
            if let et = externalType {typeString += "\(et.rawValue):" }
            return URLQueryItem(name: "filmId", value: "\(typeString)\(id)")
        }
    }
    
    //MARK: - === GENRE PARAMS ===
    public struct Genre:LBParamConvertible {
        /// Specifies a single genre to filter by.
            public var genre:Letterboxd.GenreType? = nil
            
            /// List of genres to include in the results.
            public var includeGenres:[Letterboxd.GenreType] = []
            
            /// List of genres to exclude from the results.
            public var excludeGenres:[Letterboxd.GenreType] = []
            // ...
        
        var urlQueryItems: [URLQueryItem] {
            let included = includeGenres.map { URLQueryItem(name: "includeGenre", value: $0.rawValue) }
            let excluded = excludeGenres.map { URLQueryItem(name: "excludeGenre", value: $0.rawValue) }
            return (genre.map { [URLQueryItem(name: "genre", value: $0.rawValue)] } ?? []) + included + excluded
        }
        
        // Genre
        /**
         Specifies the genre parameters for filtering films.

         - Parameter genre: Specifies a single genre to filter by.
         - Parameter includeGenres: List of genres to include in the results.
         - Parameter excludeGenres: List of genres to exclude from the results.
        */
        public init(genre: Letterboxd.GenreType? = nil,
                    includeGenres: [Letterboxd.GenreType] = [],
                    excludeGenres: [Letterboxd.GenreType] = []) {
            self.genre = genre
            self.includeGenres = includeGenres
            self.excludeGenres = excludeGenres
        }
    }

    //MARK: - === REGION PARAMS ===
    public struct Region:LBParamConvertible {
        /// The country of the film.
        public var country:String? = nil
        
        /// The language of the film.
        public var language:String? = nil
        
        var urlQueryItems: [URLQueryItem] {
            return (country.map { [URLQueryItem(name: "country", value: $0)] } ?? []) + (language.map { [URLQueryItem(name: "language", value: $0)] } ?? [])
        }
        
        // Region
        /**
         Specifies the region parameters for filtering films.

         - Parameter country: The country of the film.
         - Parameter language: The language of the film.
         */
        public init(country: String? = nil, language: String? = nil) {
            self.country = country
            self.language = language
        }
    }

    //MARK: - === RELEASE DATE PARAMS ===
    public struct ReleaseDate:LBParamConvertible {
        /// The decade when the film was released.
        public var decade: Int? = nil
        
        /// The specific year when the film was released.
        public var year:Int? = nil
        
        var urlQueryItems: [URLQueryItem] {
            return urlQueryItemsNamed(decade: "decade", year: "year")
        }
        
        // ReleaseDate
        /**
         Specifies the release date parameters for filtering films.

         - Parameter decade: The decade when the film was released.
         - Parameter year: The specific year when the film was released.
         */
        public init(decade: Int? = nil, year: Int? = nil) {
            self.decade = decade
            self.year = year
        }
        
        func urlQueryItemsNamed(decade:String, year:String) -> [URLQueryItem] {
            if let y = self.year {return [URLQueryItem(name:year, value:"\(y)")]}
            return self.decade.map{[URLQueryItem(name:decade, value:"\($0 / 10 * 10)")]} ?? []
        }
    }
    

}





