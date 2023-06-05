//
//  Shared.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    public struct Image: Codable {
        let sizes: [ImageSize]
    }

    public struct ImageSize: Codable {
        let width: Int
        let height: Int
        let url: String
    }
    
    public enum LinkType: String, Codable {
        case letterboxd
        case boxd
        case tmdb
        case imdb
        case gwi
        case justwatch
        case facebook
        case instagram
        case twitter
        case youtube
        case tickets
    }

    public struct Link: Codable {
        let type: LinkType
        let id: String
        let url: String
    }
    
    public enum CommentPolicy: String, Codable {
        case anyone = "Anyone"
        case friends = "Friends"
        case you = "You"
    }

    
}
