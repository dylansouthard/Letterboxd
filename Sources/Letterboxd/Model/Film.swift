//
//  Film.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation
extension Letterboxd {
    
    //MARK: - === FILM ===
    public struct Film:Codable {
        public let id: String
        public let name: String
        public let originalName: String?
        public let sortingName: String
        public let alternativeNames: [String]?
        public let releaseYear: Int?
        public let poster: Image?
        public let adultPoster: Image?
        public let top250Position: Int?
        public let adult: Bool
        public let reviewsHidden: Bool
        public let filmCollectionId: String?
        public let links: [Link]
        public let relationships: [MemberFilmRelationship]?
        public let genres: [Genre]
        public let tagline:String?
        public let description:String
        public let runTime:Int?
        public let backdrop:Image?
        public let backdropFocalPoint:Double?
        public let trailer:FilmTrailer?
        public let countries:[Country]
        public let languages:[Language]
        public let contributions:[FilmContributions]
        public let news:[NewsItem]?
        public let recentStories:[Story]?
        
    }
    
    
    //MARK: - === FILM SUMMARY ===
    public struct FilmSummary: Codable {
        public let id: String
        public let name: String
        public let originalName: String?
        public let sortingName: String
        public let alternativeNames: [String]?
        public let releaseYear: Int?
        public let directors: [ContributorSummary]
        public let poster: Image?
        public let adultPoster: Image?
        public let top250Position: Int?
        public let adult: Bool
        public let reviewsHidden: Bool
        public let filmCollectionId: String?
        public let links: [Link]
        public let relationships: [MemberFilmRelationship]?
        public let genres: [Genre]
    }
    
    public struct FilmIdentifier: Codable {
        public let id:String
    }
    
    public struct FilmsMetadata: Codable {
        public let totalFilmCount:Int
        public let filteredFilmCount:Int
    }
    
    public struct FilmCollection:Codable {
        public let id:String
        public let name:String
        public let films:[FilmSummary]
        public let links:[Link]
    }
    
    public struct FilmContributions:Codable {
        public let type:ContributionType
        public let contributors:[ContributorSummary]
    }
    
    public struct FilmTrailer:Codable {
        public let id:String
        public let url:String
    }
    
    public struct FilmsResponse:Codable {
        public let next:String?
        public let items:[FilmSummary]
    }
    
    //MARK: - === STATISTICS ===
    
    public struct FilmStatistics:Codable {
        public let film:FilmIdentifier
        public let counts:FilmStatisticsCounts
        public let rating:Double?
        public let ratingsHistogram:[RatingsHistogramBar]
        
    }
    
    public struct FilmStatisticsCounts:Codable {
        public let watches:Int
        public let likes:Int
        public let ratings:Int
        public let fans:Int
        public let lists:Int
        public let reviews:Int
    }
    
    public struct RatingsHistogramBar:Codable {
        public let rating:Double
        public let normalizedWeight:Double
        public let count:Int
    }
    
    
}
