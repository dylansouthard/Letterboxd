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
        
        enum SearchMethod: String, Codable, LBParamType {
            case fullText = "FullText"
            case autocomplete = "Autocomplete"
            case namesAndKeywords = "NamesAndKeywords"
            
            static var paramName:String {"searchMethod"}
        }
        
        enum SearchItemType: String, Codable, LBParamType {
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
