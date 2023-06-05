//
//  List.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    
    public struct List:Codable {
        let id: String
        let name: String
        let version: Int
        let filmCount: Int
        let published: Bool
        let ranked: Bool
        let hasEntriesWithNotes:Bool
        let descriptionLbml: String?
        let tags:[Tag]
        private let _whenCreated:String
        private let _whenPublished:String?
        let commentPolicy:CommentPolicy?
        let sharePolicy: SharePolicy
        let owner: MemberSummary
        let clonedFrom: ListIdentifier?
        let previewEntries: [ListEntrySummary]
        let links:[Link]
        let backdrop:[Image]?
        let backdropFocalPoint:Double?
        let description: String?
        
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
        var whenCreated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenCreated)
        }
        
        var whenPublished: Date? {
            return _whenPublished != nil ? Letterboxd.dateFormatter.date(from: _whenPublished!) : nil
        }
    }
    
    public struct ListSummary: Codable {
        let id: String
        let name: String
        let version: Int
        let filmCount: Int
        let published: Bool
        let ranked: Bool
        let descriptionLbml: String?
        let descriptionTruncated: Bool?
        let sharePolicy: SharePolicy
        let owner: MemberSummary
        let clonedFrom: ListIdentifier?
        let previewEntries: [ListEntrySummary]
        let entriesOfNote: [AListEntryOccurrence]?
        let description: String?
    }
    
    public enum SharePolicy: String, Codable {
        case anyone = "Anyone"
        case friends = "Friends"
        case you = "You"
    }
    
    public struct ListIdentifier: Codable {
        let id: String
    }
    
    public struct ListEntrySummary: Codable {
        let rank: Int?
        let film: FilmSummary
    }
    
    public struct AListEntryOccurrence: Codable {
        let rank: Int?
        let filmId: String
    }
    
    public struct ListResponse:Codable {
        let next:String?
        let items:[ListSummary]
    }
    
    public struct TopicsResponse:Codable {
        let next:String?
        let items:[AListTopic]
    }
    
    public struct AListTopic:Codable {
        let name:String
        let items:[ListSummary]
    }
    
    //MARK: - === Statistics ===
    public struct ListStatistics:Codable {
        let list:ListIdentifier
        let counts:ListStatisticsCounts
    }
    
    public struct ListStatisticsCounts:Codable {
        let comments:Int
        let likes:Int
    }
    
    //MARK: - =============== ENTRIES ===============
    
    public struct ListEntriesResponse:Codable {
        let next:String?
        let items:[ListEntry]
        let metadata:FilmsMetadata
        let relationships:[FilmsMemberRelationship]
    }
    
    public struct ListEntry:Codable {
        let rank: Int?
        let entryId: String
        let notesLbml: String?
        let containsSpoilers: Bool?
        let film: FilmSummary
        let notes: String?
    }
    
    //MARK: - =============== COMMENTS ===============
    public struct ListCommentsResponse: Codable {
        let next:String?
        let items:[ListComment]
    }
    
    public struct ListComment: Codable {
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
        let list: ListIdentifier
        let comment: String?
        
        var whenCreated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenCreated)
        }
        
        var whenUpdated: Date? {
            return Letterboxd.dateFormatter.date(from: _whenUpdated)
        }
        
        enum CodingKeys: String, CodingKey {
            case id, member, commentLbml, removedByAdmin, removedByContentOwner, deleted, blocked, blockedByOwner, editableWindowExpiresIn, list, comment
            
            case _whenCreated = "whenCreated"
            case _whenUpdated = "whenUpdated"
            
        }
    }
}
