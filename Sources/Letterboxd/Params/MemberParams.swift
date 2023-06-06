//
//  MemberParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension LBParams {
    
    //MARK: - =============== MEMBER ===============
    
    public struct Members:LBParamConvertible {
        var member:MemberRelationship?
        var film:MemberFilmRelationship?
        var list:MemberListRelationship?
        var review:String?
        var pagination:Pagination = Pagination()
        var sortBy:SortRule?

        
        var urlQueryItems: [URLQueryItem] {
    
          let m = (member?.urlQueryItems ?? [])
            let f = (film?.urlQueryItems ?? [])
            let l = (list?.urlQueryItems ?? [])
            let r = URLQueryItem.array(fromString: review, named: "review")
            let p = pagination.urlQueryItems
            return URLQueryItem.array(fromParam: sortBy) + m + l + r + p + f
        }
        
        // Members struct
        /**
         Specifies parameters for fetching members.

         - Parameter member: Relationship details about the member.
         - Parameter film: Film related details of the member.
         - Parameter list: List related details of the member.
         - Parameter review: Unique identifier of the member's review.
         - Parameter pagination: Parameters to control pagination.
         - Parameter sortBy: Rule by which to sort the members.
         */
        public init(member: MemberRelationship? = nil,
                    film: MemberFilmRelationship? = nil,
                    list: MemberListRelationship? = nil,
                    review: String? = nil,
                    pagination: Pagination = Pagination(),
                    sortBy: SortRule? = nil) {
            self.member = member
            self.film = film
            self.list = list
            self.review = review
            self.pagination = pagination
            self.sortBy = sortBy
        }
        
       public enum ResultsFilter:String, Codable, LBParamType {
            case noDuplicateMembers = "NoDuplicateMembers"
            static var paramName:String {"filter"}
        }
        
        public enum IncludeFriendsType: String, Codable, LBParamType {
            case none = "None"
            case all = "All"
            case only = "Only"
            static var paramName: String {"includeFriends"}
        }

        public enum SortRule: String, Codable, LBParamType {
            case date = "Date"
            case name = "Name"
            case popularity = "MemberPopularity"
            case popularityThisWeek = "MemberPopularityThisWeek"
            case popularityThisMonth = "MemberPopularityThisMonth"
            case popularityThisYear = "MemberPopularityThisYear"
            case popularityWithFriends = "MemberPopularityWithFriends"
            case popularityWithFriendsThisWeek = "MemberPopularityWithFriendsThisWeek"
            case popularityWithFriendsThisMonth = "MemberPopularityWithFriendsThisMonth"
            case popularityWithFriendsThisYear = "MemberPopularityWithFriendsThisYear"
            static var paramName:String {"sort"}
        }
        
    }
    
    public struct Activity:LBParamConvertible {
        
        var include:[ActivityType] = []
        var filters:[Filter] = []
        var adult:Bool?
        var pagination:Pagination = Pagination()
        
        var urlQueryItems: [URLQueryItem] {
            return include.map{$0.asURLQueryItem} + filters.map{$0.asURLQueryItem} + URLQueryItem.array(fromBool: adult, named: "adult") + pagination.urlQueryItems
        }
        
        // Activity struct
        /**
         Specifies parameters for fetching activities.

         - Parameter include: Array of types of activities to include.
         - Parameter filters: Array of filters to apply to the activities.
         - Parameter adult: Whether to include adult content.
         - Parameter pagination: Parameters to control pagination.
         */
        public init(include: [ActivityType] = [],
                    filters: [Filter] = [],
                    adult: Bool? = nil,
                    pagination: Pagination = Pagination()) {
            self.include = include
            self.filters = filters
            self.adult = adult
            self.pagination = pagination
        }
        
        public enum ActivityType:String, Codable, LBParamType {
            
            case reviewActivity = "ReviewActivity"
            case reviewCommentActivity = "ReviewCommentActivity"
            case reviewLikeActivity = "ReviewLikeActivity"
            case listActivity = "ListActivity"
            case listCommentActivity = "ListCommentActivity"
            case listLikeActivity = "ListLikeActivity"
            case storyActivity = "StoryActivity"
            case diaryEntryActivity = "DiaryEntryActivity"
            case filmRatingActivity = "FilmRatingActivity"
            case filmWatchActivity = "FilmWatchActivity"
            case filmLikeActivity = "FilmLikeActivity"
            case watchlistActivity = "WatchlistActivity"
            case followActivity = "FollowActivity"
            case registrationActivity = "RegistrationActivity"
            case invitationAcceptedActivity = "InvitationAcceptedActivity"
            
            static var paramName: String = "include"
            
        }
        
        public enum Filter:String, Codable, LBParamType {
            
            case ownActivity = "OwnActivity"
            case notOwnActivity = "NotOwnActivity"
            case incomingActivity = "IncomingActivity"
            case notIncomingActivity = "NotIncomingActivity"
            case networkActivity = "NetworkActivity"
            
            static var paramName: String = "where"
        }
    }
    
    public struct Watchlist:LBParamConvertible {
        var films:FilmParams = FilmParams()
        var member:FilmMemberRelationship?
        var tag:Tag?
        var pagination:Pagination = Pagination()
        var sortBy:SortRule?
        var urlQueryItems: [URLQueryItem] {
            return films.urlQueryItems + (member?.urlQueryItems ?? []) + (tag?.urlQueryItems ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam: sortBy)
        }
        
        // Watchlist struct
        /**
         Specifies parameters for fetching a watchlist.

         - Parameter films: Parameters related to the films in the watchlist.
         - Parameter member: Relationship details of the member associated with the film in the watchlist.
         - Parameter tag: Tag associated with the watchlist.
         - Parameter pagination: Parameters to control pagination.
         - Parameter sortBy: Rule by which to sort the films in the watchlist.
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
        
        public enum SortRule: String, LBParamType {
            case added = "Added"
            case dateLatestFirst = "DateLatestFirst"
            case dateEarliestFirst = "DateEarliestFirst"
            case shuffle = "Shuffle"
            case filmName = "FilmName"
            case ownerRatingHighToLow = "OwnerRatingHighToLow"
            case ownerRatingLowToHigh = "OwnerRatingLowToHigh"
            case authenticatedMemberRatingHighToLow = "AuthenticatedMemberRatingHighToLow"
            case authenticatedMemberRatingLowToHigh = "AuthenticatedMemberRatingLowToHigh"
            case memberRatingHighToLow = "MemberRatingHighToLow"
            case memberRatingLowToHigh = "MemberRatingLowToHigh"
            case averageRatingHighToLow = "AverageRatingHighToLow"
            case averageRatingLowToHigh = "AverageRatingLowToHigh"
            case releaseDateLatestFirst = "ReleaseDateLatestFirst"
            case releaseDateEarliestFirst = "ReleaseDateEarliestFirst"
            case filmDurationShortestFirst = "FilmDurationShortestFirst"
            case filmDurationLongestFirst = "FilmDurationLongestFirst"
            case filmPopularity = "FilmPopularity"
            case ratingHighToLow = "RatingHighToLow"
            case ratingLowToHigh = "RatingLowToHigh"
            case filmPopularityThisWeek = "FilmPopularityThisWeek"
            case filmPopularityThisMonth = "FilmPopularityThisMonth"
            case filmPopularityThisYear = "FilmPopularityThisYear"
            
            static var paramName: String {"sort"}
        }
        
    }
    
   
}

