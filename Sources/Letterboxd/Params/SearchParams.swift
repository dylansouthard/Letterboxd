//
//  SearchParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation
extension LBParams {
    public struct Search:LBParamConvertible {
        var include:[SearchItemType] = []
        var contributionType:Letterboxd.ContributionType?
        var searchMethod:SearchMethod?
        var adult:Bool?
        var pagination:Pagination = Pagination()
        
        var urlQueryItems: [URLQueryItem] {
            var i = include
            if contributionType != nil && !i.contains(.contributor) {i.append(.contributor)}
            return i.asURLQueryItems + URLQueryItem.array(fromParam: contributionType) + URLQueryItem.array(fromParam: searchMethod) + URLQueryItem.array(fromBool: adult, named: "adult") + pagination.urlQueryItems
        }
        
        /**
        Represents the search criteria for a Letterboxd search request.

        - Parameter include: Specifies the types of items to include in the search results. Defaults to an empty array.
        - Parameter contributionType: Specifies the type of contributions to include in the search results.
        - Parameter searchMethod: Specifies the method to use when conducting the search.
        - Parameter adult: Specifies whether to include adult content in the search results. Defaults to false.
        - Parameter pagination: Specifies the pagination rules for the search results. Defaults to an instance of Pagination with default values.
        */
        public init(include: [SearchItemType] = [], contributionType: Letterboxd.ContributionType? = nil, searchMethod: SearchMethod? = nil, adult: Bool? = nil, pagination: Pagination = Pagination()) {
            self.include = include
            self.contributionType = contributionType
            self.searchMethod = searchMethod
            self.adult = adult
            self.pagination = pagination
        }
        
       public enum SearchMethod: String, Codable, LBParamType {
            case fullText = "FullText"
            case autocomplete = "Autocomplete"
            case namesAndKeywords = "NamesAndKeywords"
            
            static var paramName:String {"searchMethod"}
        }
        
      public enum SearchItemType: String, Codable, LBParamType {
            case contributor = "ContributorSearchItem"
            case film = "FilmSearchItem"
            case list = "ListSearchItem"
            case member = "MemberSearchItem"
            case review = "ReviewSearchItem"
            case tag = "TagSearchItem"
            case story = "StorySearchItem"
            case article = "ArticleSearchItem"
            case podcast = "PodcastSearchItem"
            
            static var paramName:String {"include"}
        }
        
    }
}
