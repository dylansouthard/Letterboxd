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
        let type: ContributionType
        let filmCount: Int
    }

    public struct ContributorStatistics: Codable {
        let contributions: [ContributionStatistics]
    }

    public struct Contributor: Codable {
        let id: String
        let name: String
        let tmdbid: String?
        let statistics: ContributorStatistics
        let links: [Link]
    }
    
    public struct ContributorSummary: Codable {
        let id: String
        let name: String
        let characterName: String?
        let tmdbid: String?
    }
    
    public struct FilmContribution:Codable {
        let type:ContributionType
        let film:FilmSummary
        let characterName:String?
    }

    
    public struct FilmContributorMetadata:Codable {
        let type:ContributionType
        let data:FilmsMetadata
    }
    
    public struct FilmContributionsResponse:Codable {
        let next:String?
        let items:[FilmContribution]
        let metadata:[FilmContributorMetadata]
        let relationships:[FilmContributorMemberRelationship]
    }
    


}

