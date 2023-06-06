//
//  RelationshipParams.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-02.
//

import Foundation

protocol LBRelationshipParamType:RawRepresentable, Codable where RawValue == String {
    func urlQueryItem(_ name:String) -> URLQueryItem
}

extension LBRelationshipParamType {
    func urlQueryItem(_ name:String) -> URLQueryItem {return URLQueryItem(name: name, value: self.rawValue)}
}


extension LBParams {
    
    //MARK: - =============== MEMBER ===============
    
    public struct MemberRelationship:LBParamConvertible {
        /// The identifier for the member.
        public let member:String
        /// The type of the relationship.
        public let type:MemberRelationshipType

        
        var urlQueryItems: [URLQueryItem] {[URLQueryItem(name: "member", value: member), type.urlQueryItem("memberRelationship")]}
        
        // MemberRelationship
        /**
         Specifies a relationship between two members.

         - Parameter member: The identifier for the member.
         - Parameter type: The type of the relationship.
         */
        public init(member: String, type: MemberRelationshipType) {
            self.member = member
            self.type = type
        }
       
    }
    
    public struct MemberFilmRelationship:LBParamConvertible {
        /// The identifier for the film.
        public let film:String
        /// The type of the relationship.
        public let type:MemberFilmRelationshipType
        
        var urlQueryItems: [URLQueryItem] {[URLQueryItem(name: "film", value: film), type.urlQueryItem("filmRelationship")]}
        
        // MemberFilmRelationship
        /**
         Specifies a relationship between a member and a film.

         - Parameter film: The identifier for the film.
         - Parameter type: The type of the relationship.
         */
        public init(film: String, type: MemberFilmRelationshipType) {
            self.film = film
            self.type = type
        }
    }
    
    public struct MemberListRelationship:LBParamConvertible {
        /// The identifier for the list.
        public let list:String
        /// The type of the relationship.
        public let type:MemberListRelationshipType
        
        var urlQueryItems: [URLQueryItem] {[URLQueryItem(name: "list", value: list), type.urlQueryItem("listRelationship")]}
        
        // MemberListRelationship
        /**
         Specifies a relationship between a member and a list.

         - Parameter list: The identifier for the list.
         - Parameter type: The type of the relationship.
         */
        public init(list: String, type: MemberListRelationshipType) {
            self.list = list
            self.type = type
        }
    }
    
    //MARK: - =============== FILM ===============
    
    public struct FilmMemberRelationship:LBParamConvertible {
        /// The identifier for the member.
        public var member: String
        /// The type of the relationship.
        public var type: MemberFilmRelationshipType?
        /// Specifies if friends should be included.
        public var includeFriends: Members.IncludeFriendsType?
        
        var urlQueryItems: [URLQueryItem] { [URLQueryItem(name: "member", value: member)] + URLQueryItem.array(fromRelType:type, name: "memberRelationship") + URLQueryItem.array(fromParam: includeFriends)}
        
        // FilmMemberRelationship
        /**
         Specifies a relationship between a film and a member.

         - Parameter member: The identifier for the member.
         - Parameter type: The type of the relationship.
         - Parameter includeFriends: Specifies if friends should be included.
         */
        public init(member: String, type: MemberFilmRelationshipType? = nil, includeFriends: Members.IncludeFriendsType? = nil) {
            self.member = member
            self.type = type
            self.includeFriends = includeFriends
        }

    }
    
  
    
    //MARK: - =============== LIST ===============
    
    public struct ListMemberRelationship:LBParamConvertible {
        /// The identifier for the member.
        public var member: String
        /// The type of relationship.
        public var type: MemberListRelationshipType?
        /// Specifies if friends of the member should be included.
        public var includeFriends: Members.IncludeFriendsType?
        
        var urlQueryItems: [URLQueryItem] { [URLQueryItem(name: "member", value: member)] + URLQueryItem.array(fromRelType:type, name: "memberRelationship") + URLQueryItem.array(fromParam: includeFriends)}
        
        // ListMemberRelationship
        /**
         Specifies a relationship between a list and a member.

         - Parameter member: The identifier for the member.
         - Parameter type: The type of relationship.
         - Parameter includeFriends: Specifies if friends fo the member should be included.
         */
        public init(member: String, type: MemberListRelationshipType? = nil, includeFriends: Members.IncludeFriendsType? = nil) {
            self.member = member
            self.type = type
            self.includeFriends = includeFriends
        }
    }
    
    //MARK: - =============== LOG ENTRY ===============
    
    public struct LogEntryMemberRelationship:LBParamConvertible {
        /// The identifier for the member.
        public var member: String
        /// The type of the relationship.
        public var type: MemberLogEntryRelationshipType?
        /// The relationship type between the film and the member.
        public var filmRelationship:MemberFilmRelationshipType?
        /// Specifies if friends should be included.
        public var includeFriends: Members.IncludeFriendsType?
        
        var urlQueryItems: [URLQueryItem] { [URLQueryItem(name: "member", value: member)] + URLQueryItem.array(fromRelType:type, name: "memberRelationship") + URLQueryItem.array(fromRelType:filmRelationship, name: "filmRelationship") + URLQueryItem.array(fromParam: includeFriends)}
        
        // LogEntryMemberRelationship
        /**
         Specifies a relationship between a log entry and a member.

         - Parameter member: The identifier for the member.
         - Parameter type: The type of the relationship.
         - Parameter filmRelationship: The relationship type between the film and the member.
         - Parameter includeFriends: Specifies if friends should be included.
         */
        public init(member: String, type: MemberLogEntryRelationshipType? = nil, filmRelationship: MemberFilmRelationshipType? = nil, includeFriends: Members.IncludeFriendsType? = nil) {
            self.member = member
            self.type = type
            self.filmRelationship = filmRelationship
            self.includeFriends = includeFriends
        }
    }
    
    //MARK: - =============== STORY ===============
    public struct StoryMemberRelationship:LBParamConvertible {
        /// The identifier for the member.
        public var member:String
        /// The filters to apply.
        public var filters:[Filter] = []
        
        var urlQueryItems: [URLQueryItem] {
            return [URLQueryItem(name: "member", value: member)] + filters.asURLQueryItems
        }
        
        // StoryMemberRelationship
        /**
         Specifies a relationship between a story and a member.

         - Parameter member: The identifier for the member.
         - Parameter filters: The filters to apply.
         */
        public init(member: String, filters: [Filter] = []) {
            self.member = member
            self.filters = filters
        }
        
       public enum Filter:String, LBParamType {
            case published = "Published"
            case notPublished = "NotPublished"
            static var paramName: String {"where"}
        }
    }
    

    //MARK: - =============== ENUMS ===============
    
    public enum MemberRelationshipType: String, Codable, LBRelationshipParamType {
        case isFollowing = "IsFollowing"
        case isFollowedBy = "IsFollowedBy"
    }
    
    public enum MemberFilmRelationshipType: String, Codable, LBRelationshipParamType {
        case ignore = "Ignore"
        case watched = "Watched"
        case notWatched = "notWatched"
        case liked = "liked"
        case notLiked = "NotLiked"
        case rated = "Rated"
        case notRated = "NotRated"
        case inWatchlist = "InWatchlist"
        case notInWatchlist = "NotInWatchlist"
        case favorited = "Favorited"
    }
    
    public enum MemberListRelationshipType: String, Codable, LBRelationshipParamType {
        case owner = "Owner"
        case liked = "Liked"
        case accessed = "Accessed"
    }
    
    public enum MemberLogEntryRelationshipType:String, Codable, LBRelationshipParamType {
        case owner = "Owner"
        case liked = "Liked"
        case ignore = "Ignore"
    }
}



