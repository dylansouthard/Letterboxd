//
//  Search.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-29.
//

import Foundation

protocol LBSearchItem: Codable {
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
        let score: Double
        let type: Letterboxd.SearchItemType
        let article: NewsItem
    }
    
    public struct ContributorSearchItem: Codable, LBSearchItem {
        var score: Double
        let type: Letterboxd.SearchItemType
        let contributor: Contributor
    }
    
    public struct FilmSearchItem: Codable, LBSearchItem {
        let score:Double
        let type: Letterboxd.SearchItemType
        let film: FilmSummary
        
    }
    
    public struct ListSearchItem: Codable, LBSearchItem {
        let score: Double
        let type: Letterboxd.SearchItemType
        let list: ListSummary
    }
    
    public struct ReviewSearchItem: Codable, LBSearchItem {
        let score: Double
        let type: Letterboxd.SearchItemType
        let review: LogEntry
    }
    
    public struct MemberSearchItem:Codable, LBSearchItem {
        let score:Double
        let type: Letterboxd.SearchItemType
        let member:MemberSummary
    }
    
    public struct PodcastSearchItem: Codable, LBSearchItem {
        let score: Double
        let type: Letterboxd.SearchItemType
        let podcast: NewsItem
    }
    
    public struct StorySearchItem:Codable, LBSearchItem {
        let score:Double
        let type: Letterboxd.SearchItemType
        let story:StorySummary
    }
    
    public struct TagSearchItem: Codable, LBSearchItem {
        let score:Double
        let type: Letterboxd.SearchItemType
        let tag:Tag
    }
    
    public struct UnknownSearchItem: Codable, LBSearchItem {
        let score:Double
        let type: Letterboxd.SearchItemType
        
    }
    
    
    //MARK: - =============== RESPONSE ===============
    
    public struct SearchResponse: Decodable {
        let items: [LBSearchItem]
        let next:String?
        var cursor:String? {return next}

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
                let item = try searchItemArrayForType.nestedContainer(keyedBy: SearchItemTypeKey.self)
                let type = item.decode(SearchItemType.self, forKey: SearchItemTypeKey.type)
                switch type {
                case .contributor:
                    tryCatchPrintError {
                        let contributor = try searchItemArray.decode(ContributorSearchItem.self)
                        _items.append(contributor)
                    }
                case .film:
                    tryCatchPrintError {
                        let film = try searchItemArray.decode(FilmSearchItem.self)
                        _items.append(film)
                    }
                case .list:
                    tryCatchPrintError {
                        let film = try searchItemArray.decode(ListSearchItem.self)
                        _items.append(film)
                    }
                case .member:
                    tryCatchPrintError {
                        let item = try searchItemArray.decode(MemberSearchItem.self)
                        _items.append(item)
                    }
                case .review:
                    tryCatchPrintError {
                        let item = try searchItemArray.decode(ReviewSearchItem.self)
                        _items.append(item)
                    }
                case .tag:
                    tryCatchPrintError {
                        let item = try searchItemArray.decode(TagSearchItem.self)
                        _items.append(item)
                    }
                case .story:
                    tryCatchPrintError {
                        let item = try searchItemArray.decode(StorySearchItem.self)
                        _items.append(item)
                    }
                case .article:
                    tryCatchPrintError {
                        let item = try searchItemArray.decode(ArticleSearchItem.self)
                        _items.append(item)
                    }
                case .podcast:
                    tryCatchPrintError {
                        let item = try searchItemArray.decode(PodcastSearchItem.self)
                        _items.append(item)
                    }
                default:
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

