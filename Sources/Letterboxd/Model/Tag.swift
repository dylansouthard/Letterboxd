//
//  Tag.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {

    public struct Tag: Codable {
        public let code: String
        public let displayTag: String
    }
    
    public struct MemberTagsResponse:Codable {
        public let items:[MemberTag]
    }
    
    public struct MemberTag:Codable {
        public let code:String
        public let displayTag:String
        public let counts:MemberTagCounts
    }
    
    public struct MemberTagCounts:Codable {
        public let films:Int
        public let logEntries:Int
        public let diaryEntries:Int
        public let reviews:Int
        public let lists:Int
    }
}
