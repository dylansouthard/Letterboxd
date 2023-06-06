//
//  Me.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension Letterboxd {
    
    public struct MemberAccount:Codable {
        public let emailAddress: String?
        public let emailAddressValidated, privateAccount, includeInPeopleSection: Bool?
        public let emailWhenFollowed, emailAvailability, emailBuyAvailability, emailRentAvailability: Bool?
        public let emailComments, emailFromFollowedOnly, emailNews, emailShelfLife: Bool?
        public let emailBestInShow, emailRushes, emailPartnerMessages: Bool?
        public let devicesRegisteredForPushNotifications: [String]?
        public let pushNotificationsForGeneralAnnouncements, pushNotificationsForPartnerMessages: Bool?
        public let pushNotificationsForComments, pushNotificationsForListLikes, pushNotificationsForReviewLikes: Bool?
        public let pushNotificationsForNewFollowers, pushNotificationsForAvailability: Bool?
        public let pushNotificationsForBuyAvailability, pushNotificationsForRentAvailability: Bool?
        public let pushNotificationsFromFollowedOnly, canComment, suspended, canCloneLists: Bool?
        public let canChangeAppIcon, canFilterActivity: Bool?
        public let membershipDaysRemaining: Int?
        public let membershipWillAutoRenewViaIAP: Bool?
        public let hasActiveSubscription: Bool?
        public let subscriptionType: String?
        public let member: Member
        public let campaigns: [String]?
        public let adultContentPolicy: AdultContentPolicy?
        public let posterMode: PosterMode?
        public let posterModeOptions: [PosterMode]?
        public let commentPolicy: CommentPolicy?
        public let accountStatus: AccountStatus?
        public let hideAds, showCustomPostersAds, canHaveCustomPosters: Bool?

        public enum AdultContentPolicy: String, Codable {
               case always = "Always"
               case defaultPolicy = "Default"
           }

        public enum PosterMode: String, Codable {
               case all = "All"
               case theirs = "Theirs"
               case yours = "Yours"
               case none = "None"
           }

        public enum CommentPolicy: String, Codable {
               case anyone = "Anyone"
               case friends = "Friends"
               case you = "You"
           }

        public enum AccountStatus: String, Codable {
               case active = "Active"
               case locked = "Locked"
               case memorialized = "Memorialized"
           }
    }
    
}
