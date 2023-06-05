//
//  LogEntryParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension LBParams {
    public struct LogEntries:LBParamConvertible {
        var filters:[Filter] = []
        var film:String? = nil
        var member:LogEntryMemberRelationship? = nil
        var memberFilters:[Members.ResultsFilter] = []
        var date:DateParams?
        var rating:Rating = Rating()
        var filmDate:ReleaseDate = ReleaseDate()
        var genre:Genre = Genre()
        var region:Region = Region()
        var tag:Tag? = nil
        var service:Letterboxd.FilmService? = nil
        var pagination:Pagination = Pagination()
        var sortBy:SortRule? = nil
        
        var urlQueryItems: [URLQueryItem] {
            let _items = filters.map { $0.asURLQueryItem } + URLQueryItem.array(fromString: film, named: "film") + (member?.urlQueryItems ?? []) + (date?.urlQueryItems ?? []) + rating.urlQueryItems
            
            let _filmDate:[URLQueryItem] = filmDate.urlQueryItemsNamed(decade: "filmDecade", year: "filmYear")
            
            let _genreAndRegion:[URLQueryItem] = genre.urlQueryItems + region.urlQueryItems
            
            let _theRest:[URLQueryItem] = (tag?.urlQueryItems ?? []) + (service.map{[$0.asURLQueryItem]} ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
            
            return _items + _filmDate + _genreAndRegion + _theRest
        }
        
        enum SortRule: String, Codable, LBParamType {
            case whenAdded = "WhenAdded"
            case date = "Date"
            case diaryCount = "DiaryCount"
            case reviewCount = "ReviewCount"
            case whenLiked = "WhenLiked"
            case entryRatingHighToLow = "EntryRatingHighToLow"
            case entryRatingLowToHigh = "EntryRatingLowToHigh"
            case ratingHighToLow = "RatingHighToLow"
            case ratingLowToHigh = "RatingLowToHigh"
            case authenticatedMemberRatingHighToLow = "AuthenticatedMemberRatingHighToLow"
            case authenticatedMemberRatingLowToHigh = "AuthenticatedMemberRatingLowToHigh"
            case memberRatingHighToLow = "MemberRatingHighToLow"
            case memberRatingLowToHigh = "MemberRatingLowToHigh"
            case averageRatingHighToLow = "AverageRatingHighToLow"
            case averageRatingLowToHigh = "AverageRatingLowToHigh"
            case releaseDateLatestFirst = "ReleaseDateLatestFirst"
            case releaseDateEarliestFirst = "ReleaseDateEarliestFirst"
            case filmName = "FilmName"
            case filmDurationShortestFirst = "FilmDurationShortestFirst"
            case filmDurationLongestFirst = "FilmDurationLongestFirst"
            case reviewPopularity = "ReviewPopularity"
            case reviewPopularityThisWeek = "ReviewPopularityThisWeek"
            case reviewPopularityThisMonth = "ReviewPopularityThisMonth"
            case reviewPopularityThisYear = "ReviewPopularityThisYear"
            case reviewPopularityWithFriends = "ReviewPopularityWithFriends"
            case reviewPopularityWithFriendsThisWeek = "ReviewPopularityWithFriendsThisWeek"
            case reviewPopularityWithFriendsThisMonth = "ReviewPopularityWithFriendsThisMonth"
            case reviewPopularityWithFriendsThisYear = "ReviewPopularityWithFriendsThisYear"
            case filmPopularity = "FilmPopularity"
            case filmPopularityThisWeek = "FilmPopularityThisWeek"
            case filmPopularityThisMonth = "FilmPopularityThisMonth"
            case filmPopularityThisYear = "FilmPopularityThisYear"
            case filmPopularityWithFriends = "FilmPopularityWithFriends"
            case filmPopularityWithFriendsThisWeek = "FilmPopularityWithFriendsThisWeek"
            case filmPopularityWithFriendsThisMonth = "FilmPopularityWithFriendsThisMonth"
            case filmPopularityWithFriendsThisYear = "FilmPopularityWithFriendsThisYear"
            
            static var paramName: String{"sort"}
            
            init(from decoder: Decoder) throws {
                self = try SortRule(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .whenAdded
            }
        }
        
        enum Filter: String, LBParamType {
            case hasDiaryDate = "HasDiaryDate"
            case hasReview = "HasReview"
            case clean = "Clean"
            case noSpoilers = "NoSpoilers"
            case released = "Released"
            case notReleased = "NotReleased"
            case featureLength = "FeatureLength"
            case notFeatureLength = "NotFeatureLength"
            case inWatchlist = "InWatchlist"
            case notInWatchlist = "NotInWatchlist"
            case watched = "Watched"
            case notWatched = "NotWatched"
            case rated = "Rated"
            case notRated = "NotRated"
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
            case liked = "Liked"
            case notLiked = "NotLiked"
            case fiction = "Fiction"
            case film = "Film"
            case tv = "TV"
            static var paramName: String {"where"}
        }

    }
       
}
