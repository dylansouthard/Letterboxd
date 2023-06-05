//
//  FilmCollection.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension LBParams {
    public struct FilmCollection:LBParamConvertible {
        var films:FilmParams = FilmParams()
        var member:FilmMemberRelationship?
        var tag:Tag?
        var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return films.urlQueryItems + (member?.urlQueryItems ?? []) + (tag?.urlQueryItems ?? []) + URLQueryItem.array(fromParam:sortBy)
        }
        
        enum SortRule: String, LBParamType {
            case filmName = "FilmName"
            case releaseDateLatestFirst = "ReleaseDateLatestFirst"
            case releaseDateEarliestFirst = "ReleaseDateEarliestFirst"
            case authenticatedMemberRatingHighToLow = "AuthenticatedMemberRatingHighToLow"
            case authenticatedMemberRatingLowToHigh = "AuthenticatedMemberRatingLowToHigh"
            case memberRatingHighToLow = "MemberRatingHighToLow"
            case memberRatingLowToHigh = "MemberRatingLowToHigh"
            case averageRatingHighToLow = "AverageRatingHighToLow"
            case averageRatingLowToHigh = "AverageRatingLowToHigh"
            case filmDurationShortestFirst = "FilmDurationShortestFirst"
            case filmDurationLongestFirst = "FilmDurationLongestFirst"
            case filmPopularity = "FilmPopularity"
            case filmPopularityThisWeek = "FilmPopularityThisWeek"
            case filmPopularityThisMonth = "FilmPopularityThisMonth"
            case filmPopularityThisYear = "FilmPopularityThisYear"
            case filmPopularityWithFriends = "FilmPopularityWithFriends"
            case filmPopularityWithFriendsThisWeek = "FilmPopularityWithFriendsThisWeek"
            case filmPopularityWithFriendsThisMonth = "FilmPopularityWithFriendsThisMonth"
            case filmPopularityWithFriendsThisYear = "FilmPopularityWithFriendsThisYear"
            static var paramName:String {"sort"}
        }
        
    }
}
