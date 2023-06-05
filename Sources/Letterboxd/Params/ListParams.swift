//
//  ListParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension LBParams {
  
    
    public struct Lists:LBParamConvertible {
        var filters:[Filter] = []
        var film:String?
        var clonedFrom:String?
        var tag:Tag?
        var member:ListMemberRelationship?
        var memberFilters:[Members.ResultsFilter] = []
        var filmsOfNote:[String] = []
        var pagination:Pagination = Pagination()
        var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            let _items = filters.map{$0.asURLQueryItem} + URLQueryItem.array(fromString:film, named: "film") + URLQueryItem.array(fromString: clonedFrom, named: "clonedFrom")
            let memTags = (tag?.urlQueryItems ?? []) + (member?.urlQueryItems ?? [])
            return _items + memTags + memberFilters.map{$0.asURLQueryItem} + filmsOfNote.map{URLQueryItem(name: "filmsOfNote", value: $0)} + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
        }
        
        
        enum Filter: String, Codable, LBParamType {
            case clean = "Clean"
            case published = "Published"
            case notPublished = "NotPublished"
            case notPublishedOrShared = "NotPublishedOrShared"
            case sharedAnyone = "SharedAnyone"
            case sharedFriends = "SharedFriends"
            case owned = "Owned"
            static var paramName:String{"where"}
        }
        
        
        enum SortRule: String, Codable, LBParamType {
            case date = "Date"
            case whenLiked = "WhenLiked"
            case whenPublishedLatestFirst = "WhenPublishedLatestFirst"
            case whenPublishedEarliestFirst = "WhenPublishedEarliestFirst"
            case whenCreatedLatestFirst = "WhenCreatedLatestFirst"
            case whenCreatedEarliestFirst = "WhenCreatedEarliestFirst"
            case whenAccessedLatestFirst = "WhenAccessedLatestFirst"
            case whenAccessedEarliestFirst = "WhenAccessedEarliestFirst"
            case name = "ListName"
            case popularity = "ListPopularity"
            case popularityThisWeek = "ListPopularityThisWeek"
            case popularityThisMonth = "ListPopularityThisMonth"
            case popularityThisYear = "ListPopularityThisYear"
            case popularityWithFriends = "ListPopularityWithFriends"
            case popularityWithFriendsThisWeek = "ListPopularityWithFriendsThisWeek"
            case popularityWithFriendsThisMonth = "ListPopularityWithFriendsThisMonth"
            case popularityWithFriendsThisYear = "ListPopularityWithFriendsThisYear"
            
            static var paramName:String{"sort"}
        }
        
    }
    
    public struct ListEntries:LBParamConvertible {
        var films:FilmParams = FilmParams()
        var member:FilmMemberRelationship?
        var tag:Tag?
        var pagination:Pagination = Pagination()
        var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return films.urlQueryItems + (member?.urlQueryItems ?? []) + (tag?.urlQueryItems ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
        }
        
        enum SortRule: String, Codable, LBParamType {
            case listRanking = "ListRanking"
            case whenAddedToList = "WhenAddedToList"
            case whenAddedToListEarliestFirst = "WhenAddedToListEarliestFirst"
            case shuffle = "Shuffle"
            case filmName = "FilmName"
            case ownerRatingHighToLow = "OwnerRatingHighToLow"
            case ownerRatingLowToHigh = "OwnerRatingLowToHigh"
            case authenticatedMemberRatingHighToLow = "AuthenticatedMemberRatingHighToLow"
            case authenticatedMemberRatingLowToHigh = "AuthenticatedMemberRatingLowToHigh"
            case authenticatedMemberBasedOnLiked = "AuthenticatedMemberBasedOnLiked"
            case authenticatedMemberRelatedToLiked = "AuthenticatedMemberRelatedToLiked"
            case memberRatingHighToLow = "MemberRatingHighToLow"
            case memberRatingLowToHigh = "MemberRatingLowToHigh"
            case averageRatingHighToLow = "AverageRatingHighToLow"
            case averageRatingLowToHigh = "AverageRatingLowToHigh"
            case releaseDateLatestFirst = "ReleaseDateLatestFirst"
            case releaseDateEarliestFirst = "ReleaseDateEarliestFirst"
            case filmDurationShortestFirst = "FilmDurationShortestFirst"
            case filmDurationLongestFirst = "FilmDurationLongestFirst"
            case filmPopularity = "FilmPopularity"
            static var paramName: String {"sort"}
        }
        
    }
}
