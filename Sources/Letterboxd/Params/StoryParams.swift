//
//  StoryParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-05.
//

import Foundation

extension LBParams {
    
    public struct Stories:LBParamConvertible {
        var member:StoryMemberRelationship?
        var sortBy:SortRule?
        var pagination:Pagination = Pagination()
        
        var urlQueryItems: [URLQueryItem] {
            return (member?.urlQueryItems ?? []) + URLQueryItem.array(fromParam: sortBy) + pagination.urlQueryItems
        }
        
        enum SortRule: String, LBParamType {
            case whenUpdatedLatestFirst = "WhenUpdatedLatestFirst"
            case whenUpdatedEarliestFirst = "WhenUpdatedEarliestFirst"
            case whenPublishedLatestFirst = "WhenPublishedLatestFirst"
            case whenPublishedEarliestFirst = "WhenPublishedEarliestFirst"
            case whenCreatedLatestFirst = "WhenCreatedLatestFirst"
            case whenCreatedEarliestFirst = "WhenCreatedEarliestFirst"
            case storyTitle = "StoryTitle"
            
            static var paramName: String {"sort"}
            
        }
        
        
    }
    
}
