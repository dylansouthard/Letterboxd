//
//  News.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-04.
//

import Foundation

extension Letterboxd {
    
    public struct NewsResponse:Codable {
        let next:String?
        let items:[NewsItem]
    
    }
    public struct NewsItem: Codable {
        let title: String
        let image: Image
        let url: String
        let shortDescription: String?
        let longDescription: String?
        let episode: Int?
        let season: Int?
    }
    

    
}
