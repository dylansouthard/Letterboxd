//
//  Contributor.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    public enum ContributionType: String, Codable, LBParamType {
        case director = "Director"
        case coDirector = "CoDirector"
        case additionalDirecting = "AdditionalDirecting"
        case actor = "Actor"
        case producer = "Producer"
        case executiveProducer = "ExecutiveProducer"
        case writer = "Writer"
        case originalWriter = "OriginalWriter"
        case casting = "Casting"
        case editor = "Editor"
        case cinematography = "Cinematography"
        case additionalPhotography = "AdditionalPhotography"
        case productionDesign = "ProductionDesign"
        case artDirection = "ArtDirection"
        case setDecoration = "SetDecoration"
        case specialEffects = "SpecialEffects"
        case visualEffects = "VisualEffects"
        case stunts = "Stunts"
        case choreography = "Choreography"
        case composer = "Composer"
        case songs = "Songs"
        case sound = "Sound"
        case costumes = "Costumes"
        case makeUp = "MakeUp"
        case hairstyling = "Hairstyling"
        case studio = "Studio"
        
        static var paramName:String {"contributionType"}
    }

    public struct ContributionStatistics: Codable {
        public let type: ContributionType
        public let filmCount: Int
    }

    public struct ContributorStatistics: Codable {
        public let contributions: [ContributionStatistics]
    }

    public struct Contributor: Codable {
        public let id: String
        public let name: String
        public let tmdbid: String?
        public let statistics: ContributorStatistics
        public let links: [Link]
    }
    
    public struct ContributorSummary: Codable {
        public let id: String
        public let name: String
        public let characterName: String?
        public let tmdbid: String?
    }
    
    public struct FilmContribution:Codable {
        public let type:ContributionType
        public let film:FilmSummary
        public let characterName:String?
    }

    
    public struct FilmContributorMetadata:Codable {
        public let type:ContributionType
        public let data:FilmsMetadata
    }
    
    public struct FilmContributionsResponse:Codable {
        public let next:String?
        public let items:[FilmContribution]
        public let metadata:[FilmContributorMetadata]
        public let relationships:[FilmContributorMemberRelationship]
    }
    


}

