//
//  Pagination.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-31.
//

import Foundation

extension LBParams {
   
    public struct Pagination:LBParamConvertible {
        var cursor:String? = nil
        var perPage:Int?
        var urlQueryItems: [URLQueryItem] {
            return URLQueryItem.array(fromString: cursor, named: "cursor") + URLQueryItem.array(fromInt: perPage, named: "perPage")
        }
    }
    
    public struct Comments:LBParamConvertible {
        var includeDeletions:Bool?
        var pagination:Pagination = Pagination()
        var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return URLQueryItem.array(fromBool: includeDeletions, named: "includeDeletions") + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
        }
        
        enum SortRule:String, LBParamType {
            case date = "Date"
            case dateLatestFirst = "DateLatestFirst"
            case updates = "Updates"
            static var paramName: String {"sort"}
        }
    }
    
    public struct DateParams:LBParamConvertible {
        let year:Int
        let month:Int?
        let week:Int?
        let day:Int?
        
        var urlQueryItems: [URLQueryItem] {
            var _items = [URLQueryItem(name: "year", value: "\(year)")]
            if let m = month {
                _items.append(URLQueryItem(name: "month", value: "\(max(min(m, 12), 1))"))
                if let d = day {
                    _items.append(URLQueryItem(name: "day", value: "\(max(min(d, 31), 1))"))
                }
                return _items
            }
            
            return _items + URLQueryItem.array(fromInt: week, named: "week")
        }
    }
    
    public struct Rating:LBParamConvertible {
        var min: Double?
        var max: Double?

        func roundedToNearestHalf(_ value: Double) -> Double {
            return round(value * 2) / 2
        }

        var urlQueryItems: [URLQueryItem] {
            var items: [URLQueryItem] = []

            if var minVal = min {
                minVal = minVal > 5 ? 5 : minVal < 0.5 ? 0.5 : roundedToNearestHalf(minVal)
                items.append(URLQueryItem(name: "minRating", value: "\(minVal)"))
                if var maxVal = max {
                    maxVal = maxVal > 5 ? 5 : maxVal < 0.5 ? 0.5 : roundedToNearestHalf(maxVal)
                    maxVal = maxVal < minVal ? minVal : maxVal
                    items.append(URLQueryItem(name: "maxRating", value: "\(maxVal)"))
                }
            } else if var maxVal = max {
                maxVal = maxVal > 5 ? 5 : maxVal < 0.5 ? 0.5 : roundedToNearestHalf(maxVal)
                items.append(URLQueryItem(name: "maxRating", value: "\(maxVal)"))
            }
            
            return items
        }
    }
    
    public struct Tag:LBParamConvertible {
        let tagCode:String
        let tagger:String?
        let includeTaggerFriends:IncludeTaggerFriendsType?
        
        var urlQueryItems:[URLQueryItem] {
            return [URLQueryItem(name: "tagCode", value: tagCode)] + URLQueryItem.array(fromString:tagger, named: "tagger") + URLQueryItem.array(fromParam:includeTaggerFriends)
        }
        
        enum IncludeTaggerFriendsType:String, Codable, LBParamType {
            case none = "None"
            case all = "All"
            case only = "Only"
            
            static var paramName:String{"includeFriends"}
        }
        init(_ code:String, tagger:String? = nil, includeTaggerFriends:IncludeTaggerFriendsType? = nil) {
            self.tagCode = code
            self.tagger = tagger
            self.includeTaggerFriends = includeTaggerFriends
        }
    }
    
}


