//
//  Shared.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    public struct Image: Codable {
        public let sizes: [ImageSize]
    }

    public struct ImageSize: Codable {
        public let width: Int
        public let height: Int
        public let url: String
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
        public let type: LinkType
        public let id: String
        public let url: String
    }
    
    public enum CommentPolicy: String, Codable {
        case anyone = "Anyone"
        case friends = "Friends"
        case you = "You"
    }

    
}
