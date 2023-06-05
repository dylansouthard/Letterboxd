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
        let id: String
        let name: String
        let originalName: String?
        let sortingName: String
        let alternativeNames: [String]?
        let releaseYear: Int?
        let poster: Image?
        let adultPoster: Image?
        let top250Position: Int?
        let adult: Bool
        let reviewsHidden: Bool
        let filmCollectionId: String?
        let links: [Link]
        let relationships: [MemberFilmRelationship]?
        let genres: [Genre]
        let tagline:String?
        let description:String
        let runTime:Int?
        let backdrop:Image?
        let backdropFocalPoint:Double?
        let trailer:FilmTrailer?
        let countries:[Country]
        let languages:[Language]
        let contributions:[FilmContributions]
        let news:[NewsItem]?
        let recentStories:[Story]?
        
    }
    
    
    //MARK: - === FILM SUMMARY ===
    public struct FilmSummary: Codable {
        let id: String
        let name: String
        let originalName: String?
        let sortingName: String
        let alternativeNames: [String]?
        let releaseYear: Int?
        let directors: [ContributorSummary]
        let poster: Image?
        let adultPoster: Image?
        let top250Position: Int?
        let adult: Bool
        let reviewsHidden: Bool
        let filmCollectionId: String?
        let links: [Link]
        let relationships: [MemberFilmRelationship]?
        let genres: [Genre]
    }
    
    public struct FilmIdentifier: Codable {
        let id:String
    }
    
    public struct FilmsMetadata: Codable {
        let totalFilmCount:Int
        let filteredFilmCount:Int
    }
    
    public struct FilmCollection:Codable {
        let id:String
        let name:String
        let films:[FilmSummary]
        let links:[Link]
    }
    
    public struct FilmContributions:Codable {
        let type:ContributionType
        let contributors:[ContributorSummary]
    }
    
    public struct FilmTrailer:Codable {
        let id:String
        let url:String
    }
    
    public struct FilmsResponse:Codable {
        let next:String?
        let items:[FilmSummary]
    }
    
    //MARK: - === STATISTICS ===
    
    public struct FilmStatistics:Codable {
        let film:FilmIdentifier
        let counts:FilmStatisticsCounts
        let rating:Double?
        let ratingsHistogram:[RatingsHistogramBar]
        
    }
    
    public struct FilmStatisticsCounts:Codable {
        let watches:Int
        let likes:Int
        let ratings:Int
        let fans:Int
        let lists:Int
        let reviews:Int
    }
    
    public struct RatingsHistogramBar:Codable {
        let rating:Double
        let normalizedWeight:Double
        let count:Int
    }
    
    
}
