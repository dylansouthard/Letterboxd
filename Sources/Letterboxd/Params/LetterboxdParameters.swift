//
//  LetterboxdParameters.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-25.
//

import Foundation

protocol LBParamType: RawRepresentable { static var paramName: String { get }}

protocol LBParamConvertible { var urlQueryItems:[URLQueryItem] {get} }

public struct LBParams {}


//MARK: - A convenience extension to convert parameter values into URLQueryItems

extension Collection where Element: LBParamType {
    var asURLQueryItems: [URLQueryItem] {
        self.map {
            URLQueryItem(name: Element.paramName, value: "\($0.rawValue)")
        }
    }
}

extension Collection where Element == Letterboxd.GenreType {
    var includeGenres: [URLQueryItem] {
        self.map {
            URLQueryItem(name: "includeGenre", value: "\($0.rawValue)")
        }
    }
    
    var excludeGenres: [URLQueryItem] {
        self.map {
            URLQueryItem(name: "excludeGenre", value: "\($0.rawValue)")
        }
    }
}

extension LBParamType {
    var asURLQueryItem: URLQueryItem {
        URLQueryItem(name: Self.paramName, value: "\(self.rawValue)")
    }
}

//EXTENSION TO APPEND CURSOR AND PERPAGE IF PRESENT


//CONVENIENCE EXTENSION FOR COMMON QUERY ITEMS

extension URLQueryItem {
    
    static func adult(_ value:Bool) -> URLQueryItem {return URLQueryItem(name: "adult", value: "\(value)")}
    
    static func clonedFrom(_ value:String) -> URLQueryItem {return URLQueryItem(name:"clonedFrom", value:value)}
    
    static func film(_ value:String) -> URLQueryItem {return URLQueryItem(name:"film", value:value)}
    
    static func input(_ value:String) -> URLQueryItem {return URLQueryItem(name: "input", value: value)}
    
    static func array<T: LBParamType>(fromParam value: T?) -> [URLQueryItem] {
        return value.map { [$0.asURLQueryItem] } ?? []
    }
    
    static func array(fromInt value:Int?, named name:String)->[URLQueryItem] {
        return value.map{[URLQueryItem(name: name, value: "\($0)")]} ?? []
    }
    
    static func array(fromRelType value:(any LBRelationshipParamType)?, name:String)->[URLQueryItem] {
        return value.map{[$0.urlQueryItem(name)]} ?? []
    }
    
    static func array(fromString value:String?, named name:String)->[URLQueryItem] {
        return value.map{[URLQueryItem(name: name, value: $0)]} ?? []
    }
    
    static func array(fromBool value:Bool?, named name:String)->[URLQueryItem] {
        return value.map{[URLQueryItem(name: name, value: "\($0)")]} ?? []
    }
    
}

//CONVENIENCE EXTENSION FOR PARAMS SETS
extension Array where Element == URLQueryItem {
  
    mutating func appendParamsSet(_ paramsSet:LBParamConvertible?) {
        guard let p = paramsSet else {return}
        self.append(contentsOf: p.urlQueryItems)
    }
}


