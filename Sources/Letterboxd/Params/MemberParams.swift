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
        
        
        enum ResultsFilter:String, Codable, LBParamType {
            case noDuplicateMembers = "NoDuplicateMembers"
            static var paramName:String {"filter"}
        }
        
        enum IncludeFriendsType: String, Codable, LBParamType {
            case none = "None"
            case all = "All"
            case only = "Only"
            static var paramName: String {"includeFriends"}
        }

        enum SortRule: String, Codable, LBParamType {
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
        
        
        enum ActivityType:String, Codable, LBParamType {
            
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
        
        enum Filter:String, Codable, LBParamType {
            
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
        
        enum SortRule: String, LBParamType {
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

