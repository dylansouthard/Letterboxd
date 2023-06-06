//
//  Story.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {
    
    public struct Story:Codable {
        public let id: String
        public let name: String
        public let author: MemberSummary
        public let url: String?
        public let source: String?
        public let videoUrl: String?
        public let bodyHtml: String?
        public let bodyLbml: String?
        public let whenUpdated: String
        public let whenCreated: String
        public let image: Image?
        
    }
  
    public struct StorySummary:Codable {
        public let id: String
        public let name: String
        public let author: MemberSummary
        public let url: String?
        public let source: String?
        public let videoUrl: String?
        public let bodyHtml: String?
        public let bodyLbml: String?
        public let bodyTruncated: Bool?
        public let whenUpdated: String
        public let whenCreated: String
        public let image: Image?
    }
    
    public struct StoriesResponse:Codable {
        public let next:String?
        public let items:[StorySummary]
    }
}


