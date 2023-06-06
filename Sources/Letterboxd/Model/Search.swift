//
//  Search.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

public protocol LBSearchItem: Codable {
    var score: Double {get}
    var type: Letterboxd.SearchItemType { get }
}

extension Letterboxd {
    
    //MARK: - =============== SEARCH ITEM TYPES ===============
    
    public enum SearchItemType: String, Codable {
        
        case contributor = "ContributorSearchItem"
        case film = "FilmSearchItem"
        case list = "ListSearchItem"
        case member = "MemberSearchItem"
        case review = "ReviewSearchItem"
        case tag = "TagSearchItem"
        case story = "StorySearchItem"
        case article = "ArticleSearchItem"
        case podcast = "PodcastSearchItem"
        case unknown
        
        
    }
    
    //MARK: - =============== SEARCH ITEMS ===============
    
    public struct ArticleSearchItem: Codable, LBSearchItem {
        public let score: Double
        public let type: Letterboxd.SearchItemType
        public let article: NewsItem
    }
    
    public struct ContributorSearchItem: Codable, LBSearchItem {
        public let score: Double
        public let type: Letterboxd.SearchItemType
        public let contributor: Contributor
    }
    
    public struct FilmSearchItem: Codable, LBSearchItem {
        public let score:Double
        public let type: Letterboxd.SearchItemType
        public let film: FilmSummary
        
    }
    
    public struct ListSearchItem: Codable, LBSearchItem {
        public let score: Double
        public let type: Letterboxd.SearchItemType
        public let list: ListSummary
    }
    
    public struct ReviewSearchItem: Codable, LBSearchItem {
        public let score: Double
        public let type: Letterboxd.SearchItemType
        public let review: LogEntry
    }
    
    public struct MemberSearchItem:Codable, LBSearchItem {
        public let score:Double
        public let type: Letterboxd.SearchItemType
        public let member:MemberSummary
    }
    
    public struct PodcastSearchItem: Codable, LBSearchItem {
        public let score: Double
        public let type: Letterboxd.SearchItemType
        public let podcast: NewsItem
    }
    
    public struct StorySearchItem:Codable, LBSearchItem {
        public let score:Double
        public let type: Letterboxd.SearchItemType
        public let story:StorySummary
    }
    
    public struct TagSearchItem: Codable, LBSearchItem {
        public let score:Double
        public let type: Letterboxd.SearchItemType
        public let tag:Tag
    }
    
    public struct UnknownSearchItem: Codable, LBSearchItem {
        public let score:Double
        public let type: Letterboxd.SearchItemType
        
    }
    
    
    //MARK: - =============== RESPONSE ===============
    
    public struct SearchResponse: Decodable {
        public let items: [LBSearchItem]
        public let next:String?
        
        enum SearchResponseKey: String, CodingKey {
            case items
            case next
        }
        
        enum SearchItemTypeKey: CodingKey {
            case type
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: SearchResponseKey.self)
            var searchItemArrayForType = try container.nestedUnkeyedContainer(forKey: SearchResponseKey.items)
            var _items = [LBSearchItem]()
            
            var searchItemArray = searchItemArrayForType
            
            while(!searchItemArrayForType.isAtEnd) {
                do {
                    let item = try searchItemArrayForType.nestedContainer(keyedBy: SearchItemTypeKey.self)
                    let type = item.decode(SearchItemType.self, forKey: SearchItemTypeKey.type)
                    switch type {
                    case .contributor:
                        let contributor = try searchItemArray.decode(ContributorSearchItem.self)
                        _items.append(contributor)
                        
                    case .film:
                        let film = try searchItemArray.decode(FilmSearchItem.self)
                        _items.append(film)
                        
                    case .list:
                        let film = try searchItemArray.decode(ListSearchItem.self)
                        _items.append(film)
                        
                    case .member:
                        let item = try searchItemArray.decode(MemberSearchItem.self)
                        _items.append(item)
                        
                    case .review:
                        let item = try searchItemArray.decode(ReviewSearchItem.self)
                        _items.append(item)
                        
                    case .tag:
                        let item = try searchItemArray.decode(TagSearchItem.self)
                        _items.append(item)
                        
                    case .story:
                        let item = try searchItemArray.decode(StorySearchItem.self)
                        _items.append(item)
                        
                    case .article:
                        let item = try searchItemArray.decode(ArticleSearchItem.self)
                        _items.append(item)
                        
                    case .podcast:
                        let item = try searchItemArray.decode(PodcastSearchItem.self)
                        _items.append(item)
                        
                    default:
                        let item = try searchItemArray.decode(UnknownSearchItem.self)
                        _items.append(item)
                        
                    }
                } catch let error {
                    print(error)
                    tryCatchPrintError {
                        let item = try searchItemArray.decode(UnknownSearchItem.self)
                        _items.append(item)
                    }
                }
                
            }
            self.items = _items
            self.next = try? container.decode(String.self, forKey: .next)
        }
        
    }
}




extension KeyedDecodingContainer {
    func decode(_ type: Letterboxd.SearchItemType.Type, forKey key: Key) -> Letterboxd.SearchItemType {
        return (try? decodeIfPresent(type, forKey: key)) ?? .unknown
    }
}

