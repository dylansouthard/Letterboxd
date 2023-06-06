//
//  Relationship.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    public struct MemberFilmRelationship: Codable {
        public let member: MemberSummary
        public let relationship: FilmRelationship
    }

    public struct FilmRelationshipResults:Codable {
        public let items:[MemberFilmRelationship]
        public let watchCount:Int?
        public let watchListCount:Int?
    }
    
    public struct FilmRelationship: Codable {
        public  let watched: Bool
        public let whenWatched: String?
        public let liked: Bool
        public let whenLiked: String?
        public let favorited: Bool
        public let owned: Bool?
        public let inWatchlist: Bool
        public let whenAddedToWatchlist: String?
        public let whenCompletedInWatchlist: String?
        public let rating: Double?
        public let reviews: [String]
        public let diaryEntries: [String]
    }
    
    public struct FilmContributorMemberRelationship: Codable {
        public let member:MemberSummary
        public let relationships:[FilmContributorRelationship]
    }
    
    public struct FilmContributorRelationship: Codable {
        public let type:ContributionType
        public let relationship:FilmsRelationship
    }
    
    public struct FilmsRelationship: Codable {
        public let counts:FilmsRelationshipCounts
    }
    
    public struct FilmsRelationshipCounts: Codable {
        public let watches:Int
        public let likes:Int
    }
    
    public struct FilmsMemberRelationship:Codable {
        public let member:MemberSummary
        public let relationship:FilmsRelationship
    }
    
    //MARK: - =============== LIST/Review ===============
    public struct ListRelationship: Codable {
        public let liked: Bool
        public let subscribed: Bool
        public let subscriptionState: SubscriptionState
        public let commentThreadState: CommentThreadState

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
