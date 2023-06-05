//
//  Activity.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-02.
//

import Foundation

protocol LBActivity: Codable {
    var member: Letterboxd.MemberSummary { get }
    var whenCreated: String { get }
    var type: Letterboxd.ActivityType { get }
}

extension Letterboxd {
    
   public enum ActivityType: String, Codable {
        case diaryEntryActivity = "DiaryEntryActivity"
        case filmLikeActivity = "FilmLikeActivity"
        case filmRatingActivity = "FilmRatingActivity"
        case filmWatchActivity = "FilmWatchActivity"
        case followActivity = "FollowActivity"
        case invitationAcceptedActivity = "InvitationAcceptedActivity"
        case listActivity = "ListActivity"
        case listCommentActivity = "ListCommentActivity"
        case listLikeActivity = "ListLikeActivity"
        case registrationActivity = "RegistrationActivity"
        case reviewActivity = "ReviewActivity"
        case reviewCommentActivity = "ReviewCommentActivity"
        case reviewLikeActivity = "ReviewLikeActivity"
        case storyActivity = "StoryActivity"
        case watchlistActivity = "WatchlistActivity"
        case unknown
    }

    public struct ActivityResponse: Decodable {
        let items: [LBActivity]
        let next: String?
        var cursor: String? { return next }

        enum ActivityResponseKey: String, CodingKey {
            case items
            case next
        }

        enum ActivityItemTypeKey: CodingKey {
            case type
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: ActivityResponseKey.self)
            var activityArrayForType = try container.nestedUnkeyedContainer(forKey: ActivityResponseKey.items)
            var _items = [LBActivity]()
            
            var activityArray = activityArrayForType
            do {
                while(!activityArrayForType.isAtEnd) {
                    let item = try activityArrayForType.nestedContainer(keyedBy: ActivityItemTypeKey.self)
                    let type = item.decode(ActivityType.self, forKey: ActivityItemTypeKey.type)
                    
                    switch type {
                    case .diaryEntryActivity:
                        let diaryEntryActivity = try activityArray.decode(DiaryEntryActivity.self)
                        _items.append(diaryEntryActivity)
                    case .filmLikeActivity:
                        let filmLikeActivity = try activityArray.decode(FilmLikeActivity.self)
                        _items.append(filmLikeActivity)
                    case .filmRatingActivity:
                        let filmRatingActivity = try activityArray.decode(FilmRatingActivity.self)
                        _items.append(filmRatingActivity)
                    case .filmWatchActivity:
                        let filmWatchActivity = try activityArray.decode(FilmWatchActivity.self)
                        _items.append(filmWatchActivity)
                    case .followActivity:
                        let followActivity = try activityArray.decode(FollowActivity.self)
                        _items.append(followActivity)
                    case .invitationAcceptedActivity:
                        let invitationAcceptedActivity = try activityArray.decode(InvitationAcceptedActivity.self)
                        _items.append(invitationAcceptedActivity)
                    case .listActivity:
                        let listActivity = try activityArray.decode(ListActivity.self)
                        _items.append(listActivity)
                    case .listCommentActivity:
                        let listCommentActivity = try activityArray.decode(ListCommentActivity.self)
                        _items.append(listCommentActivity)
                    case .listLikeActivity:
                        let listLikeActivity = try activityArray.decode(ListLikeActivity.self)
                        _items.append(listLikeActivity)
                    case .registrationActivity:
                        let registrationActivity = try activityArray.decode(RegistrationActivity.self)
                        _items.append(registrationActivity)
                    case .reviewActivity:
                        let reviewActivity = try activityArray.decode(ReviewActivity.self)
                        _items.append(reviewActivity)
                    case .reviewCommentActivity:
                        let reviewCommentActivity = try activityArray.decode(ReviewCommentActivity.self)
                        _items.append(reviewCommentActivity)
                    case .reviewLikeActivity:
                        let reviewLikeActivity = try activityArray.decode(ReviewLikeActivity.self)
                        _items.append(reviewLikeActivity)
                    case .storyActivity:
                        let storyActivity = try activityArray.decode(StoryActivity.self)
                        _items.append(storyActivity)
                    case .watchlistActivity:
                        let watchlistActivity = try activityArray.decode(WatchlistActivity.self)
                        _items.append(watchlistActivity)
                    case .unknown:
                        tryCatchPrintError {
                            let item = try activityArray.decode(UnknownActivity.self)
                            _items.append(item)
                        }
                    }
                }
            } catch let error {
                print(error)
                tryCatchPrintError {
                    let item = try activityArray.decode(UnknownActivity.self)
                    _items.append(item)
                }
            }
            
            self.items = _items
            self.next = try? container.decode(String.self, forKey: .next)
        }

    }
    
    public struct DiaryEntryActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let diaryEntry: LogEntry
        let type: Letterboxd.ActivityType
    }

    public struct FilmLikeActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let film: FilmSummary
        let type: Letterboxd.ActivityType
    }

    public struct FilmRatingActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let film: FilmSummary
        let rating: Double
        let type: Letterboxd.ActivityType
    }

    public struct FilmWatchActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let film: FilmSummary
        let type: Letterboxd.ActivityType
    }

    public struct FollowActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let followed: MemberSummary
        let type: Letterboxd.ActivityType
    }

    public struct InvitationAcceptedActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let invitor: MemberSummary
        let type: Letterboxd.ActivityType
    }

    public struct ListActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let list: ListSummary
        let clonedFrom: ListSummary?
        let type: Letterboxd.ActivityType
    }

    public struct ListCommentActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let list: ListSummary
        let comment: ListComment
        let type: Letterboxd.ActivityType
    }
    
    public struct ListLikeActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let list: ListSummary
        let type: Letterboxd.ActivityType
    }

    public struct RegistrationActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let type: Letterboxd.ActivityType
    }

    public struct ReviewActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let review: LogEntry
        let type: Letterboxd.ActivityType
    }

    public struct ReviewCommentActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let review: LogEntry
        let comment: ReviewComment
        let type: Letterboxd.ActivityType
    }

    public struct ReviewLikeActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let review: LogEntry
        let type: Letterboxd.ActivityType
    }

    public struct StoryActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let story: StorySummary
        let type: Letterboxd.ActivityType
    }

    public struct WatchlistActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let film: FilmSummary
        let type: Letterboxd.ActivityType
    }
    
    public struct UnknownActivity: Codable, LBActivity {
        let whenCreated: String
        let member: MemberSummary
        let type: Letterboxd.ActivityType
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: Letterboxd.ActivityType.Type, forKey key: Key) -> Letterboxd.ActivityType {
        return (try? decodeIfPresent(type, forKey: key)) ?? .unknown
    }
}
