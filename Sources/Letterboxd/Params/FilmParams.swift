//
//  Film.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-30.
//

import Foundation
extension LBParams {

    public struct Films:LBParamConvertible {
        var films:FilmParams = FilmParams()
        var member:FilmMemberRelationship?
        var tag:Tag?
        var pagination:Pagination = Pagination()
        var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return films.urlQueryItems + (member?.urlQueryItems ?? []) + (tag?.urlQueryItems ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
        }
        
        enum SortRule: String, Codable, LBParamType {
            
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
        
        var member:MemberRelationship?
        var pagination = Pagination()
        var sortBy:Members.SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return (member?.urlQueryItems ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam: sortBy)
        }
    }
    
    //MARK: - =============== SHARED FILMS PARAMS ===============
    public struct FilmParams:LBParamConvertible {
        
        var filmIDs:[FilmID] = []
        var genre:Genre = Genre()
        var region:Region = Region()
        var releaseDate:ReleaseDate = ReleaseDate()
        var service:Letterboxd.FilmService? = nil
        var filters:[Filter] = []
        
        var urlQueryItems: [URLQueryItem] {
            return filmIDs.map{$0.asURLQueryItem} + genre.urlQueryItems + region.urlQueryItems + releaseDate.urlQueryItems + (service.map{[$0.asURLQueryItem]} ?? []) + filters.map{$0.asURLQueryItem}
        }
        
        enum Filter: String, Codable, LBParamType {
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
        let id:String
        let externalType:ExternalFilmIDType?
        
        enum ExternalFilmIDType:String {
            case tmdb
            case imdb
            
        }
        
        init(_ id:String, externalType:ExternalFilmIDType? = nil) {
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
        
        var genre:Letterboxd.GenreType? = nil
        var includeGenres:[Letterboxd.GenreType] = []
        var excludeGenres:[Letterboxd.GenreType] = []
        
        var urlQueryItems: [URLQueryItem] {
            let included = includeGenres.map { URLQueryItem(name: "includeGenre", value: $0.rawValue) }
            let excluded = excludeGenres.map { URLQueryItem(name: "excludeGenre", value: $0.rawValue) }
            return (genre.map { [URLQueryItem(name: "genre", value: $0.rawValue)] } ?? []) + included + excluded
        }
    }

    //MARK: - === REGION PARAMS ===
    public struct Region:LBParamConvertible {
        var country:String? = nil
        var language:String? = nil
        
        var urlQueryItems: [URLQueryItem] {
            return (country.map { [URLQueryItem(name: "country", value: $0)] } ?? []) + (language.map { [URLQueryItem(name: "language", value: $0)] } ?? [])
        }
    }

    //MARK: - === RELEASE DATE PARAMS ===
    public struct ReleaseDate:LBParamConvertible {
        var decade: Int? = nil
        var year:Int? = nil
        
        var urlQueryItems: [URLQueryItem] {
            return urlQueryItemsNamed(decade: "decade", year: "year")
        }
        
        func urlQueryItemsNamed(decade:String, year:String) -> [URLQueryItem] {
            if let y = self.year {return [URLQueryItem(name:year, value:"\(y)")]}
            return self.decade.map{[URLQueryItem(name:decade, value:"\($0 / 10 * 10)")]} ?? []
        }
    }
    

}





