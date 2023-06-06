//
//  News.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-04.
//

import Foundation

extension Letterboxd {
    
    public struct NewsResponse:Codable {
        public let next:String?
        public let items:[NewsItem]
    
    }
    public struct NewsItem: Codable {
        public let title: String
        public let image: Image
        public let url: String
        public let shortDescription: String?
        public let longDescription: String?
        public let episode: Int?
        public let season: Int?
    }
    

    
}
