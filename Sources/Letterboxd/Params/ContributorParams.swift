//
//  ContributorParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension LBParams {
    public struct Contributions:LBParamConvertible {
        
        var contribution:Letterboxd.ContributionType? = nil
        var films:FilmParams = FilmParams()
        var member:FilmMemberRelationship? = nil
        var tag:Tag? = nil
        var pagination:Pagination = Pagination()
        var sortBy:SortRule? = nil
        
        
        
        var urlQueryItems: [URLQueryItem] {
            let items = pagination.urlQueryItems + films.urlQueryItems + (member?.urlQueryItems ?? [])
            let cont:[URLQueryItem] = (contribution.map{[URLQueryItem(name:"type", value:$0.rawValue)]} ?? [])
            
            return items  + cont + (tag?.urlQueryItems ?? []) + URLQueryItem.array(fromParam:sortBy)
        }
        
        // Contributions
        /**
         Parameters to recieve contributions of a contributor to films.
         - Parameter contribution: Specifies the type of contribution.
         - Parameter films: Filters to be applied on the retrieved films.
         - Parameter member: Specifies the member and type of relationship for the returned films.
         - Parameter tag: Specifies the tag to filter the contributions.
         - Parameter pagination: Pagination settings for the retrieved list.
         - Parameter sortBy: Determines the sorting rule for the retrieved list.
         
         */
        public init(pagination: Pagination = Pagination(),
                    films: FilmParams = FilmParams(),
                    member: FilmMemberRelationship? = nil,
                    tag: Tag? = nil,
                    sortBy: SortRule? = nil,
                    contribution: Letterboxd.ContributionType? = nil) {
            self.pagination = pagination
            self.films = films
            self.member = member
            self.tag = tag
            self.sortBy = sortBy
            self.contribution = contribution
        }
                
        
        //MARK: - === ENUMS ===
        public enum SortRule:String, LBParamType {
            case billing = "Billing"
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
            static var paramName: String{"sort"}
        }
        
    }
}
