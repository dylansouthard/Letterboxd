//
//  DataLists.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-30.
//

import Foundation

extension Letterboxd {
    
    //MARK: - =============== COUNTRIES ===============
    public struct CountriesResponse:Codable {
        let items:[Country]
    }
    
    public struct Country:Codable {
        let code:String
        let name:String
    }
    
    
    //MARK: - =============== SERVICES ===============
    public struct FilmServicesResponse:Codable {
        let items:[FilmService]
    }
    
    public struct FilmService:Codable {
        let id:String
        let name:String
        let icon:String?
        
        var asURLQueryItem:URLQueryItem{URLQueryItem(name: "service", value: self.id)}
        
        static let myServices = FilmService(id: "my-services-all", name: "My Services", icon:nil)
    }
    
    //MARK: - =============== GENRES ===============
    public struct GenresResponse: Codable {
        let items:[Genre]
    }
    
    public struct Genre: Codable {
        let id: String
        let name: String
    }
    
    
    public enum GenreType:String, LBParamType {
        case action = "8G"
            case adventure = "9k"
            case animation = "8m"
            case comedy = "7I"
            case crime = "9Y"
            case documentary = "ai"
            case drama = "7S"
            case family = "8w"
            case fantasy = "82"
            case history = "90"
            case horror = "aC"
            case music = "b6"
            case mystery = "aW"
            case romance = "8c"
            case scienceFiction = "9a"
            case thriller = "a8"
            case tvMovie = "1hO"
            case war = "9u"
            case western = "8Q"
        static var paramName = "genre"
        
        public var genre: Genre {
            switch self {
            case .action: return Genre(id: "8G", name: "Action")
            case .adventure: return Genre(id: "9k", name: "Adventure")
            case .animation: return Genre(id: "8m", name: "Animation")
            case .comedy: return Genre(id: "7I", name: "Comedy")
            case .crime: return Genre(id: "9Y", name: "Crime")
            case .documentary: return Genre(id: "ai", name: "Documentary")
            case .drama: return Genre(id: "7S", name: "Drama")
            case .family: return Genre(id: "8w", name: "Family")
            case .fantasy: return Genre(id: "82", name: "Fantasy")
            case .history: return Genre(id: "90", name: "History")
            case .horror: return Genre(id: "aC", name: "Horror")
            case .music: return Genre(id: "b6", name: "Music")
            case .mystery: return Genre(id: "aW", name: "Mystery")
            case .romance: return Genre(id: "8c", name: "Romance")
            case .scienceFiction: return Genre(id: "9a", name: "Science Fiction")
            case .thriller: return Genre(id: "a8", name: "Thriller")
            case .tvMovie: return Genre(id: "1hO", name: "TV Movie")
            case .war: return Genre(id: "9u", name: "War")
            case .western: return Genre(id: "8Q", name: "Western")
            }
        }
    }
    
    //MARK: - =============== LANGUAGES ===============
    public struct LanguagesResponse: Codable {
        let items:[Language]
    }
    
    public struct Language:Codable {
        let code:String
        let name:String
    }
    
}
