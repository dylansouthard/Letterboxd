//
//  LogEntry.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension Letterboxd {
    
    public struct LogEntriesResponse:Codable {
        public let next:String?
        public let items:[LogEntry]
    }
    
    public struct LogEntry: Codable {
        public let id: String
        public let name: String
        public let owner: MemberSummary
        public let film: FilmSummary?
        public let diaryDetails: DiaryDetails?
        public let review: Review?
        public let tags: [Tag]
        public let whenCreated: String
        public let whenUpdated: String
        public let rating: Double?
        public let like: Bool
        public let commentable: Bool
        public let commentPolicy: CommentPolicy?
        public let links: [Link]
        public let backdrop: Image?
        public let backdropFocalPoint: Double?
        
        enum CodingKeys: String, CodingKey {
            case id, name, owner, film, diaryDetails, review, whenCreated, whenUpdated, rating, like, commentable, commentPolicy, links, backdrop, backdropFocalPoint
            case tags = "tags2"
        }
    }
    
    public struct DiaryDetails: Codable {
        public let diaryDate: String
        public let rewatch: Bool
    }
    
    public struct Review: Codable {
        public let lbml: String
        public let containsSpoilers: Bool
        public let moderated: Bool
        public let whenReviewed: String
        public let text: String
    }
    
    public struct ReviewCommentsResponse: Codable {
        public let next:String?
        public let items:[ReviewComment]
    }
    
    public struct ReviewComment: Codable {
        public let id: String
        public let member: MemberSummary
        private let _whenCreated: String
        private let _whenUpdated: String
        public let commentLbml: String?
        public let removedByAdmin: Bool
        public let removedByContentOwner: Bool
        public let deleted: Bool
        public let blocked: Bool
        public let blockedByOwner: Bool
        public let editableWindowExpiresIn: Int?
        public let review: ReviewIdentifier
        public let comment: String?
        
        public var whenCreated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenCreated)
        }
        
        public var whenUpdated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenUpdated)
        }
        
        enum CodingKeys: String, CodingKey {
            case id, member, commentLbml, removedByAdmin, removedByContentOwner, deleted, blocked, blockedByOwner, editableWindowExpiresIn, review, comment
            
            case _whenCreated = "whenCreated"
            case _whenUpdated = "whenUpdated"
            
        }
    }
    
    public struct ReviewIdentifier:Codable {
        public let id:String
    }
    
    public struct ReviewStatistics:Codable {
        public let logEntry:ReviewIdentifier
        public let counts:ReviewStatisticsCounts
    }
    
    public  struct ReviewStatisticsCounts:Codable {
        public let comments:Int
        public let likes:Int
    }
    
    
    public struct ReviewRelationship:Codable {
        public let liked:Bool
        public let subscribed:Bool
        public let subscriptionState:ReviewSubscriptionState
        public let commentThreadState:CommentThreadState
        
    }
    
    public enum ReviewSubscriptionState:String, Codable {
        case subscribed = "Subscribed"
        case notSubscribed = "NotSubscribed"
        case unsubscribed = "Unsubscribed"
    }
    
    
    
    
    
}
