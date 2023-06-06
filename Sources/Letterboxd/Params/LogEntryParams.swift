//
//  LogEntryParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension LBParams {
    public struct LogEntries:LBParamConvertible {
        /// Array of filter rules applied to the log entries.
        public var filters:[Filter] = []
        
        /// The unique identifier of the film in the log entries.
        public var film:String? = nil
        
        /// The relationship of the log entry with a member.
        public var member:LogEntryMemberRelationship? = nil
        
        /// Array of filters applied to the log entry members.
        public var memberFilters:[Members.ResultsFilter] = []
        
        /// Parameters related to the date of the log entry.
        public var date:DateParams?
        
        /// Parameters related to the rating of the log entry.
        public var rating:Rating = Rating()
        
        /// Parameters related to the release date of the film in the log entry.
        public var filmDate:ReleaseDate = ReleaseDate()
        
        /// Parameters related to the genre of the film in the log entry.
        public var genre:Genre = Genre()
        
        /// Parameters related to the region of the film in the log entry.
        public var region:Region = Region()
        
        /// The tag associated with the log entry.
        public var tag:Tag? = nil
        
        /// The streaming service where the film is available.
        public var service:Letterboxd.FilmService? = nil
        
        /// Parameters to control pagination.
        public var pagination:Pagination = Pagination()
        
        /// Rule by which to sort the log entries.
        public var sortBy:SortRule? = nil
        
        var urlQueryItems: [URLQueryItem] {
            let _items = filters.map { $0.asURLQueryItem } + URLQueryItem.array(fromString: film, named: "film") + (member?.urlQueryItems ?? []) + (date?.urlQueryItems ?? []) + rating.urlQueryItems
            
            let _filmDate:[URLQueryItem] = filmDate.urlQueryItemsNamed(decade: "filmDecade", year: "filmYear")
            
            let _genreAndRegion:[URLQueryItem] = genre.urlQueryItems + region.urlQueryItems
            
            let _theRest:[URLQueryItem] = (tag?.urlQueryItems ?? []) + (service.map{[$0.asURLQueryItem]} ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
            
            return _items + _filmDate + _genreAndRegion + _theRest
        }
        
        /**
         Specifies parameters for fetching log entries.
         
         - Parameter filters: Array of filter rules applied to the log entries.
         - Parameter film: The unique identifier of the film in the log entries.
         - Parameter member: The relationship of the log entry with a member.
         - Parameter memberFilters: Array of filters applied to the log entry members.
         - Parameter date: Parameters related to the date of the log entry.
         - Parameter rating: Parameters related to the rating of the log entry.
         - Parameter filmDate: Parameters related to the release date of the film in the log entry.
         - Parameter genre: Parameters related to the genre of the film in the log entry.
         - Parameter region: Parameters related to the region of the film in the log entry.
         - Parameter tag: The tag associated with the log entry.
         - Parameter service: The streaming service where the film is available.
         - Parameter pagination: Parameters to control pagination.
         - Parameter sortBy: Rule by which to sort the log entries.
         */
        public init(filters: [Filter] = [],
                    film: String? = nil,
                    member: LogEntryMemberRelationship? = nil,
                    memberFilters: [Members.ResultsFilter] = [],
                    date: DateParams? = nil,
                    rating: Rating = Rating(),
                    filmDate: ReleaseDate = ReleaseDate(),
                    genre: Genre = Genre(),
                    region: Region = Region(),
                    tag: Tag? = nil,
                    service: Letterboxd.FilmService? = nil,
                    pagination: Pagination = Pagination(),
                    sortBy: SortRule? = nil) {
            self.filters = filters
            self.film = film
            self.member = member
            self.memberFilters = memberFilters
            self.date = date
            self.rating = rating
            self.filmDate = filmDate
            self.genre = genre
            self.region = region
            self.tag = tag
            self.service = service
            self.pagination = pagination
            self.sortBy = sortBy
        }
        
        
        public enum SortRule: String, Codable, LBParamType {
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
            
            public init(from decoder: Decoder) throws {
                self = try SortRule(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .whenAdded
            }
        }
        
        public enum Filter: String, LBParamType {
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
