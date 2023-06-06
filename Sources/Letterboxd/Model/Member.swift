//
//  Member.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    
    public struct Member:Codable {
        public let id, username:String
        public let givenName, familyName: String?
        public let displayName, shortName: String
        public let pronoun: Pronoun
        public let avatar: Image
        public let memberStatus: MemberStatus
        public let hideAdsInContent: Bool
        public let commentPolicy: CommentPolicy?
        public let accountStatus: AccountStatus
        public let hideAds: Bool
        public let twitterUsername: String?
        public let bioLbml, location, website: String?
        public let backdrop: Image?
        public let backdropFocalPoint: Double?
        public let favoriteFilms: [FilmSummary]
        public let pinnedFilmLists: [ListSummary]?
        public let pinnedReviews: [LogEntry]?
        public let links: [Link]
        public let privateWatchlist: Bool
        public let featuredList: ListSummary?
        public let teamMembers: [MemberSummary]?
        public let orgType: OrgType?
        public let bio: String?
    }
    
    public struct MemberSummary: Codable {
        public let id: String
        public let username: String
        public let givenName: String?
        public let familyName: String?
        public let displayName: String
        public let shortName: String
        public let pronoun: Pronoun
        public let avatar: Image
        public let memberStatus: MemberStatus
        public let hideAdsInContent: Bool
        public let commentPolicy: CommentPolicy?
        public let accountStatus: AccountStatus
        public let hideAds: Bool
    }
    
    public struct MembersResponse:Codable {
        public let next:String?
        public let items:[MemberSummary]
    }
    
    //MARK: - === RELATIONSHIP ===
    
    public struct MemberRelationship:Codable {
        public let following:Bool
        public let followedBy:Bool
        public let blocking:Bool
        public let blockedBy:Bool
    }
    
    //MARK: - === STATISTICS ===
    public struct MemberStatistics:Codable {
        public let member:MemberIdentifier
        public let counts:MemberStatisticsCounts
        public let ratingsHistogram:[RatingsHistogramBar]
        public let yearsInReview:[Int]?
        
    }
    
    public struct MemberStatisticsCounts: Codable {
        public let filmLikes: Int
        public let listLikes: Int
        public let reviewLikes: Int
        public let watches: Int
        public let ratings: Int
        public let reviews: Int
        public let diaryEntries: Int
        public let diaryEntriesThisYear: Int
        public let filmsInDiaryThisYear: Int
        public let filmsInDiaryLastYear: Int
        public let watchlist: Int
        public let lists: Int
        public let unpublishedLists: Int
        public let followers: Int
        public let following: Int
        public let listTags: Int
        public let filmTags: Int
    }
    
    public struct MemberIdentifier:Codable {
        public let id:String
    }
    
    public enum MemberStatus: String, Codable {
        case crew = "Crew"
        case alum = "Alum"
        case hq = "Hq"
        case patron = "Patron"
        case pro = "Pro"
        case member = "Member"
    }
    
    public enum AccountStatus: String, Codable {
        case active = "Active"
        case locked = "Locked"
        case memorialized = "Memorialized"
    }
    
    //MARK: - === PRONOUNS ===
    
    public struct PronounsResponse:Codable {
        public let items:[Pronoun]
    }
    
    public struct Pronoun: Codable {
        public let id: String
        public let label: String
        public let subjectPronoun: String
        public let objectPronoun: String
        public let possessiveAdjective: String
        public let possessivePronoun: String
        public let reflexive: String
    }
    
    public enum OrgType: String, Codable {
            case society = "Society"
            case educator = "Educator"
            case exhibitor = "Exhibitor"
            case festival = "Festival"
            case singleFilm = "Single_Film"
            case genre = "Genre"
            case association = "Association"
            case mediaPublisher = "Media_Publisher"
            case productPlatform = "Product_Platform"
            case podcast = "Podcast"
            case streamer = "Streamer"
            case studio = "Studio"
        }    
}
