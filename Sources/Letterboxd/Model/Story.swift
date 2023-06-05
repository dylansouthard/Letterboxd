//
//  Story.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    
    public struct Story:Codable {
        let id: String
            let name: String
            let author: MemberSummary
            let url: String?
            let source: String?
            let videoUrl: String?
            let bodyHtml: String?
            let bodyLbml: String?
            let whenUpdated: String
            let whenCreated: String
            let image: Image?
        
    }
  
    public struct StorySummary:Codable {
        let id: String
        let name: String
        let author: MemberSummary
        let url: String?
        let source: String?
        let videoUrl: String?
        let bodyHtml: String?
        let bodyLbml: String?
        let bodyTruncated: Bool?
        let whenUpdated: String
        let whenCreated: String
        let image: Image?
    }
    
    public struct StoriesResponse:Codable {
        let next:String?
        let items:[StorySummary]
    }
}


