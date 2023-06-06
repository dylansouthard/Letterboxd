//
//  ListParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension LBParams {
    
    
    public struct Lists:LBParamConvertible {
        /// Array of filter rules applied to the lists.
        public var filters:[Filter] = []
        
        /// The unique identifier of a film.
        public var film:String?
        
        /// The unique identifier of a list from which the list was cloned.
        public var clonedFrom:String?
        
        /// The tag associated with the list.
        public var tag:Tag?
        
        /// The relationship of the list with a member.
        public var member:ListMemberRelationship?
        
        /// Array of filters applied to the list members.
        public var memberFilters:[Members.ResultsFilter] = []
        
        /// Array of identifiers of notable films.
        public var filmsOfNote:[String] = []
        
        /// Parameters to control pagination.
        public var pagination:Pagination = Pagination()
        
        /// Rule by which to sort the lists.
        public var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            let _items = filters.map{$0.asURLQueryItem} + URLQueryItem.array(fromString:film, named: "film") + URLQueryItem.array(fromString: clonedFrom, named: "clonedFrom")
            let memTags = (tag?.urlQueryItems ?? []) + (member?.urlQueryItems ?? [])
            return _items + memTags + memberFilters.map{$0.asURLQueryItem} + filmsOfNote.map{URLQueryItem(name: "filmsOfNote", value: $0)} + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
        }
        
        // Lists
        /**
         Specifies parameters for fetching lists.
         
         - Parameter filters: Array of filter rules applied to the lists.
         - Parameter film: The unique identifier of a film.
         - Parameter clonedFrom: The unique identifier of a list from which the list was cloned.
         - Parameter tag: The tag associated with the list.
         - Parameter member: The relationship of the list with a member.
         - Parameter memberFilters: Array of filters applied to the list members.
         - Parameter filmsOfNote: Array of identifiers of notable films.
         - Parameter pagination: Parameters to control pagination.
         - Parameter sortBy: Rule by which to sort the lists.
         */
        public init(filters: [Filter] = [],
                    film: String? = nil,
                    clonedFrom: String? = nil,
                    tag: Tag? = nil,
                    member: ListMemberRelationship? = nil,
                    memberFilters: [Members.ResultsFilter] = [],
                    filmsOfNote: [String] = [],
                    pagination: Pagination = Pagination(),
                    sortBy: SortRule? = nil) {
            self.filters = filters
            self.film = film
            self.clonedFrom = clonedFrom
            self.tag = tag
            self.member = member
            self.memberFilters = memberFilters
            self.filmsOfNote = filmsOfNote
            self.pagination = pagination
            self.sortBy = sortBy
        }
        
        
        public enum Filter: String, Codable, LBParamType {
            case clean = "Clean"
            case published = "Published"
            case notPublished = "NotPublished"
            case notPublishedOrShared = "NotPublishedOrShared"
            case sharedAnyone = "SharedAnyone"
            case sharedFriends = "SharedFriends"
            case owned = "Owned"
            static var paramName:String{"where"}
        }
        
        
        public enum SortRule: String, Codable, LBParamType {
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
        /// Parameters related to films to be included in the results.
        public var films:FilmParams = FilmParams()
        
        /// The relationship of the entry with a member.
        public var member:FilmMemberRelationship?
        
        /// The tag associated with the entry.
        public var tag:Tag?
        
        /// Parameters to control pagination.
        public var pagination:Pagination = Pagination()
        
        /// Rule by which to sort the list entries.
        public var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return films.urlQueryItems + (member?.urlQueryItems ?? []) + (tag?.urlQueryItems ?? []) + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
        }
        
        // ListEntries
        /**
         Specifies parameters for fetching entries from a list.
         
         - Parameter films: Parameters related to films to be included in the results.
         - Parameter member: The relationship of the entry with a member.
         - Parameter tag: The tag associated with the entry.
         - Parameter pagination: Parameters to control pagination.
         - Parameter sortBy: Rule by which to sort the list entries.
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
        
        public enum SortRule: String, Codable, LBParamType {
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
