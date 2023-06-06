//
//  List.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    
    public struct List:Codable {
        public let id: String
        public let name: String
        public let version: Int
        public let filmCount: Int
        public let published: Bool
        public let ranked: Bool
        public let hasEntriesWithNotes:Bool
        public let descriptionLbml: String?
        public let tags:[Tag]
        private let _whenCreated:String
        private let _whenPublished:String?
        public let commentPolicy:CommentPolicy?
        public let sharePolicy: SharePolicy
        public let owner: MemberSummary
        public let clonedFrom: ListIdentifier?
        public let previewEntries: [ListEntrySummary]
        public let links:[Link]
        public let backdrop:[Image]?
        public let backdropFocalPoint:Double?
        public let description: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name, version, filmCount, published, ranked
            case hasEntriesWithNotes
            case descriptionLbml
            case tags = "tags2" // map the variable "tags2" onto tags
            case _whenCreated = "whenCreated"
            case _whenPublished = "whenPublished"
            case commentPolicy, sharePolicy, owner, clonedFrom, previewEntries, links, backdrop, backdropFocalPoint, description
        }
        
        // Computed Date variables
        public var whenCreated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenCreated)
        }
        
        public var whenPublished: Date? {
            return _whenPublished != nil ? Letterboxd.dateFormatter.date(from: _whenPublished!) : nil
        }
    }
    
    public struct ListSummary: Codable {
        public let id: String
        public let name: String
        public let version: Int
        public let filmCount: Int
        public let published: Bool
        public let ranked: Bool
        public let descriptionLbml: String?
        public let descriptionTruncated: Bool?
        public let sharePolicy: SharePolicy
        public let owner: MemberSummary
        public let clonedFrom: ListIdentifier?
        public let previewEntries: [ListEntrySummary]
        public let entriesOfNote: [AListEntryOccurrence]?
        public let description: String?
    }
    
    public enum SharePolicy: String, Codable {
        case anyone = "Anyone"
        case friends = "Friends"
        case you = "You"
    }
    
    public struct ListIdentifier: Codable {
        public let id: String
    }
    
    public struct ListEntrySummary: Codable {
        public let rank: Int?
        public let film: FilmSummary
    }
    
    public struct AListEntryOccurrence: Codable {
        public let rank: Int?
        public let filmId: String
    }
    
    public struct ListResponse:Codable {
        public let next:String?
        public let items:[ListSummary]
    }
    
    public struct TopicsResponse:Codable {
        public let next:String?
        public let items:[AListTopic]
    }
    
    public struct AListTopic:Codable {
        public let name:String
        public let items:[ListSummary]
    }
    
    //MARK: - === Statistics ===
    public struct ListStatistics:Codable {
        public let list:ListIdentifier
        public let counts:ListStatisticsCounts
    }
    
    public struct ListStatisticsCounts:Codable {
        public let comments:Int
        public let likes:Int
    }
    
    //MARK: - =============== ENTRIES ===============
    
    public struct ListEntriesResponse:Codable {
        public let next:String?
        public let items:[ListEntry]
        public let metadata:FilmsMetadata
        public let relationships:[FilmsMemberRelationship]
    }
    
    public struct ListEntry:Codable {
        public let rank: Int?
        public let entryId: String
        public let notesLbml: String?
        public let containsSpoilers: Bool?
        public let film: FilmSummary
        public let notes: String?
    }
    
    //MARK: - =============== COMMENTS ===============
    public struct ListCommentsResponse: Codable {
        public let next:String?
        public let items:[ListComment]
    }
    
    public struct ListComment: Codable {
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
        public let list: ListIdentifier
        public let comment: String?
        
        public var whenCreated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenCreated)
        }
        
        public var whenUpdated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenUpdated)
        }
        
        enum CodingKeys: String, CodingKey {
            case id, member, commentLbml, removedByAdmin, removedByContentOwner, deleted, blocked, blockedByOwner, editableWindowExpiresIn, list, comment
            
            case _whenCreated = "whenCreated"
            case _whenUpdated = "whenUpdated"
            
        }
    }
}
