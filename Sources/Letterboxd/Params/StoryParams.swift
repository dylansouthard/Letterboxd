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
        
        /**
        Represents the request parameters for a Letterboxd stories request.

        - Parameter member: Specifies the member relationship to include in the stories results.
        - Parameter sortBy: Specifies the rule to use when sorting the stories results.
        - Parameter pagination: Specifies the pagination rules for the stories results. Defaults to an instance of Pagination with default values.
        */
        public init(member: StoryMemberRelationship? = nil, sortBy: SortRule? = nil, pagination: Pagination = Pagination()) {
            self.member = member
            self.sortBy = sortBy
            self.pagination = pagination
        }
        
        public enum SortRule: String, LBParamType {
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
