//
//  LogEntry.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension Letterboxd {
    
    public struct LogEntriesResponse:Codable {
        let next:String?
        let items:[LogEntry]
    }
    
    public struct LogEntry: Codable {
        let id: String
        let name: String
        let owner: MemberSummary
        let film: FilmSummary?
        let diaryDetails: DiaryDetails?
        let review: Review?
        let tags: [Tag]
        let whenCreated: String
        let whenUpdated: String
        let rating: Double?
        let like: Bool
        let commentable: Bool
        let commentPolicy: CommentPolicy?
        let links: [Link]
        let backdrop: Image?
        let backdropFocalPoint: Double?

        enum CodingKeys: String, CodingKey {
            case id, name, owner, film, diaryDetails, review, whenCreated, whenUpdated, rating, like, commentable, commentPolicy, links, backdrop, backdropFocalPoint
            case tags = "tags2"
        }
    }
    
    public struct DiaryDetails: Codable {
        let diaryDate: String
        let rewatch: Bool
    }

    public struct Review: Codable {
        let lbml: String
        let containsSpoilers: Bool
        let moderated: Bool
        let whenReviewed: String
        let text: String
    }
    
    public struct ReviewCommentsResponse: Codable {
        let next:String?
        let items:[ReviewComment]
    }
    
    public struct ReviewComment: Codable {
        let id: String
        let member: MemberSummary
        private let _whenCreated: String
        private let _whenUpdated: String
        let commentLbml: String?
        let removedByAdmin: Bool
        let removedByContentOwner: Bool
        let deleted: Bool
        let blocked: Bool
        let blockedByOwner: Bool
        let editableWindowExpiresIn: Int?
        let review: ReviewIdentifier
        let comment: String?

        var whenCreated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenCreated)
        }
        
        var whenUpdated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenUpdated)
        }

        enum CodingKeys: String, CodingKey {
            case id, member, commentLbml, removedByAdmin, removedByContentOwner, deleted, blocked, blockedByOwner, editableWindowExpiresIn, review, comment
        
            case _whenCreated = "whenCreated"
            case _whenUpdated = "whenUpdated"
           
        }
    }
    
    public struct ReviewIdentifier:Codable {
        let id:String
    }
    
    public struct ReviewStatistics:Codable {
        let logEntry:ReviewIdentifier
        let counts:ReviewStatisticsCounts
    }
    
    public  struct ReviewStatisticsCounts:Codable {
        let comments:Int
        let likes:Int
    }
    
    
    public struct ReviewRelationship:Codable {
        let liked:Bool
        let subscribed:Bool
        let subscriptionState:ReviewSubscriptionState
        let commentThreadState:CommentThreadState
        
    }
    
    public enum ReviewSubscriptionState:String, Codable {
        case subscribed = "Subscribed"
        case notSubscribed = "NotSubscribed"
        case unsubscribed = "Unsubscribed"
    }
    
    
    
    
    
}
