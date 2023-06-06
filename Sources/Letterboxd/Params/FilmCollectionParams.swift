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
        
        // FilmCollection
        /**
         Retrieves a collection of films based on specified parameters.

         - Parameter films: Filters to be applied on the retrieved films.
         - Parameter member: Specifies the member and type of relationship.
         - Parameter tag: Specifies the tag to filter the film collection.
         - Parameter sortBy: Determines the sorting rule for the retrieved list.
         */
        public init(films: FilmParams = FilmParams(),
                    member: FilmMemberRelationship? = nil,
                    tag: Tag? = nil,
                    sortBy: SortRule? = nil) {
            self.films = films
            self.member = member
            self.tag = tag
            self.sortBy = sortBy
        }
        
        public enum SortRule: String, LBParamType {
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
