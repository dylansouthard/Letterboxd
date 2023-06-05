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
        let member:String
        let type:MemberRelationshipType
        
        var urlQueryItems: [URLQueryItem] {[URLQueryItem(name: "member", value: member), type.urlQueryItem("memberRelationship")]}
    }
    
    public struct MemberFilmRelationship:LBParamConvertible {
        let film:String
        let type:MemberFilmRelationshipType
        var urlQueryItems: [URLQueryItem] {[URLQueryItem(name: "film", value: film), type.urlQueryItem("filmRelationship")]}
    }
    
    public struct MemberListRelationship:LBParamConvertible {
        let list:String
        let type:MemberListRelationshipType
        var urlQueryItems: [URLQueryItem] {[URLQueryItem(name: "list", value: list), type.urlQueryItem("listRelationship")]}
    }
    
    //MARK: - =============== FILM ===============
    
    public struct FilmMemberRelationship:LBParamConvertible {
        var member: String
        var type: MemberFilmRelationshipType?
        var includeFriends: Members.IncludeFriendsType?
        
        var urlQueryItems: [URLQueryItem] { [URLQueryItem(name: "member", value: member)] + URLQueryItem.array(fromRelType:type, name: "memberRelationship") + URLQueryItem.array(fromParam: includeFriends)}
    }
    
    //MARK: - =============== LIST ===============
    
    public struct ListMemberRelationship:LBParamConvertible {
        var member: String
        var type: MemberListRelationshipType?
        var includeFriends: Members.IncludeFriendsType?
        
        var urlQueryItems: [URLQueryItem] { [URLQueryItem(name: "member", value: member)] + URLQueryItem.array(fromRelType:type, name: "memberRelationship") + URLQueryItem.array(fromParam: includeFriends)}
    }
    
    //MARK: - =============== LOG ENTRY ===============
    
    public struct LogEntryMemberRelationship:LBParamConvertible {
        var member: String
        var type: MemberLogEntryRelationshipType?
        var filmRelationship:MemberFilmRelationshipType?
        var includeFriends: Members.IncludeFriendsType?
        
        var urlQueryItems: [URLQueryItem] { [URLQueryItem(name: "member", value: member)] + URLQueryItem.array(fromRelType:type, name: "memberRelationship") + URLQueryItem.array(fromRelType:filmRelationship, name: "filmRelationship") + URLQueryItem.array(fromParam: includeFriends)}
    }
    
    //MARK: - =============== STORY ===============
    public struct StoryMemberRelationship:LBParamConvertible {
        var member:String
        var filters:[Filter] = []
        
        var urlQueryItems: [URLQueryItem] {
            return [URLQueryItem(name: "member", value: member)] + filters.asURLQueryItems
        }
        
        enum Filter:String, LBParamType {
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



