//
//  Tag.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

extension Letterboxd {


    
    public struct Tag: Codable {
        let code: String
        let displayTag: String
    }
    
    public struct MemberTagsResponse:Codable {
        let items:[MemberTag]
    }
    
    public struct MemberTag:Codable {
        let code:String
        let displayTag:String
        let counts:MemberTagCounts
    }
    
    public struct MemberTagCounts:Codable {
        let films:Int
        let logEntries:Int
        let diaryEntries:Int
        let reviews:Int
        let lists:Int
    }
}
