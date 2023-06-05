//
//  Relationship.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    public struct MemberFilmRelationship: Codable {
        let member: MemberSummary
        let relationship: FilmRelationship
    }

    public struct FilmRelationshipResults:Codable {
        let items:[MemberFilmRelationship]
        let watchCount:Int?
        let watchListCount:Int?
    }
    
    public struct FilmRelationship: Codable {
        let watched: Bool
        let whenWatched: String?
        let liked: Bool
        let whenLiked: String?
        let favorited: Bool
        let owned: Bool?
        let inWatchlist: Bool
        let whenAddedToWatchlist: String?
        let whenCompletedInWatchlist: String?
        let rating: Double?
        let reviews: [String]
        let diaryEntries: [String]
    }
    
    public struct FilmContributorMemberRelationship: Codable {
        let member:MemberSummary
        let relationships:[FilmContributorRelationship]
    }
    
    public struct FilmContributorRelationship: Codable {
        let type:ContributionType
        let relationship:FilmsRelationship
    }
    
    public struct FilmsRelationship: Codable {
        let counts:FilmsRelationshipCounts
    }
    
    public struct FilmsRelationshipCounts: Codable {
        let watches:Int
        let likes:Int
    }
    
    public struct FilmsMemberRelationship:Codable {
        let member:MemberSummary
        let relationship:FilmsRelationship
    }
    
    //MARK: - =============== LIST/Review ===============
    public struct ListRelationship: Codable {
        let liked: Bool
        let subscribed: Bool
        let subscriptionState: SubscriptionState
        let commentThreadState: CommentThreadState

    }
    
    public enum SubscriptionState: String, Codable {
        case subscribed = "Subscribed"
        case notSubscribed = "NotSubscribed"
        case unsubscribed = "Unsubscribed"
    }

    public enum CommentThreadState: String, Codable {
        case banned = "Banned"
        case blocked = "Blocked"
        case blockedThem = "BlockedThem"
        case canComment = "CanComment"
        case closed = "Closed"
        case friendsOnly = "FriendsOnly"
        case moderated = "Moderated"
        case notCommentable = "NotCommentable"
        case notValidated = "NotValidated"
    }
    
}
