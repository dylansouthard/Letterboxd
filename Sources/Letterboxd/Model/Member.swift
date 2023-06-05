//
//  Member.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    
    public struct Member:Codable {
        let id, username:String
            let givenName, familyName: String?
            let displayName, shortName: String
            let pronoun: Pronoun
            let avatar: Image
            let memberStatus: MemberStatus
            let hideAdsInContent: Bool
            let commentPolicy: CommentPolicy?
            let accountStatus: AccountStatus
            let hideAds: Bool
            let twitterUsername: String?
            let bioLbml, location, website: String?
            let backdrop: Image?
            let backdropFocalPoint: Double?
            let favoriteFilms: [FilmSummary]
            let pinnedFilmLists: [ListSummary]?
            let pinnedReviews: [LogEntry]?
            let links: [Link]
            let privateWatchlist: Bool
            let featuredList: ListSummary?
            let teamMembers: [MemberSummary]?
            let orgType: OrgType?
            let bio: String?
    }
    
    public struct MemberSummary: Codable {
        let id: String
        let username: String
        let givenName: String?
        let familyName: String?
        let displayName: String
        let shortName: String
        let pronoun: Pronoun
        let avatar: Image
        let memberStatus: MemberStatus
        let hideAdsInContent: Bool
        let commentPolicy: CommentPolicy?
        let accountStatus: AccountStatus
        let hideAds: Bool
    }
    
    public struct MembersResponse:Codable {
        let next:String?
        let items:[MemberSummary]
    }
    
    //MARK: - === RELATIONSHIP ===
    
    public struct MemberRelationship:Codable {
        let following:Bool
        let followedBy:Bool
        let blocking:Bool
        let blockedBy:Bool
    }
    
    //MARK: - === STATISTICS ===
    public struct MemberStatistics:Codable {
        let member:MemberIdentifier
        let counts:MemberStatisticsCounts
        let ratingsHistogram:[RatingsHistogramBar]
        let yearsInReview:[Int]?
        
    }
    
    public struct MemberStatisticsCounts: Codable {
        let filmLikes: Int
        let listLikes: Int
        let reviewLikes: Int
        let watches: Int
        let ratings: Int
        let reviews: Int
        let diaryEntries: Int
        let diaryEntriesThisYear: Int
        let filmsInDiaryThisYear: Int
        let filmsInDiaryLastYear: Int
        let watchlist: Int
        let lists: Int
        let unpublishedLists: Int
        let followers: Int
        let following: Int
        let listTags: Int
        let filmTags: Int
    }
    
    public struct MemberIdentifier:Codable {
        let id:String
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
        let items:[Pronoun]
    }
    
    public struct Pronoun: Codable {
        let id: String
        let label: String
        let subjectPronoun: String
        let objectPronoun: String
        let possessiveAdjective: String
        let possessivePronoun: String
        let reflexive: String
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
