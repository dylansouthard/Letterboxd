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
        
        // Pagination
        /**
         Indicates the start point and number of results per page.

         - Parameters:
           - cursor: Indicates the starting point of a page. Returned as "next" from previous results.
           - perPage: The number of items per page.
         */
        public init(cursor: String? = nil, perPage: Int? = nil) {
            self.cursor = cursor
            self.perPage = perPage
        }
    }
    
    public struct Comments:LBParamConvertible {
        var includeDeletions:Bool?
        var pagination:Pagination = Pagination()
        var sortBy:SortRule?
        
        var urlQueryItems: [URLQueryItem] {
            return URLQueryItem.array(fromBool: includeDeletions, named: "includeDeletions") + pagination.urlQueryItems + URLQueryItem.array(fromParam:sortBy)
        }
        
        // Comments
        /**
         Initializes a new Comments struct.

         - Parameters:
           - includeDeletions: Indicates if deleted comments should be included in the response.
           - pagination: The pagination parameters.
           - sortBy: Determines the sorting rule for the comments.
         */
        
        public enum SortRule:String, LBParamType {
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
        
        // DateParams
        /**
         Limits items returned to within the specified date range.

         - Parameters:
           - year: Represents the year in the date parameters.
           - month: Represents the month in the date parameters (requires year).
           - week: Represents the week in the date parameters (requires year. If month or day is specified this will be ignored).
           - day: Represents the day in the date parameters.
         */
        public init(year: Int,
                    month: Int? = nil,
                    week: Int? = nil,
                    day: Int? = nil) {
            self.year = year
            self.month = month
            self.week = week
            self.day = day
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
        
        // Rating
        /**
         Specify the rating for the returned items.

         - Parameters:
           - min: Lower bound of the rating range. Should be between 0.5 and 5.
           - max: Upper bound of the rating range. Should be between `min` and 5.
         */
        public init(min: Double? = nil, max: Double? = nil) {
            self.min = min
            self.max = max
        }

    }
    
    public struct Tag:LBParamConvertible {
        let tagCode:String
        let tagger:String?
        let includeTaggerFriends:IncludeTaggerFriendsType?
        
        var urlQueryItems:[URLQueryItem] {
            return [URLQueryItem(name: "tagCode", value: tagCode)] + URLQueryItem.array(fromString:tagger, named: "tagger") + URLQueryItem.array(fromParam:includeTaggerFriends)
        }
        
        public enum IncludeTaggerFriendsType:String, Codable, LBParamType {
            case none = "None"
            case all = "All"
            case only = "Only"
            
            static var paramName:String{"includeFriends"}
        }
        
        // Tag
        /**
         Gets results for items with the specified tag.

         - Parameters:
           - tagCode: Identifier for the tag.
           - tagger: Identifier of the user who added the tag.
           - includeTaggerFriends: Specifies whether to include friends of the tagger in the response.
         */
        
        public init(_ code:String, tagger:String? = nil, includeTaggerFriends:IncludeTaggerFriendsType? = nil) {
            self.tagCode = code
            self.tagger = tagger
            self.includeTaggerFriends = includeTaggerFriends
        }
    }
    
}


