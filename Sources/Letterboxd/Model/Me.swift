//
//  Me.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-01.
//

import Foundation

extension Letterboxd {
    
    public struct MemberAccount:Codable {
        let emailAddress: String?
           let emailAddressValidated, privateAccount, includeInPeopleSection: Bool?
           let emailWhenFollowed, emailAvailability, emailBuyAvailability, emailRentAvailability: Bool?
           let emailComments, emailFromFollowedOnly, emailNews, emailShelfLife: Bool?
           let emailBestInShow, emailRushes, emailPartnerMessages: Bool?
           let devicesRegisteredForPushNotifications: [String]?
           let pushNotificationsForGeneralAnnouncements, pushNotificationsForPartnerMessages: Bool?
           let pushNotificationsForComments, pushNotificationsForListLikes, pushNotificationsForReviewLikes: Bool?
           let pushNotificationsForNewFollowers, pushNotificationsForAvailability: Bool?
           let pushNotificationsForBuyAvailability, pushNotificationsForRentAvailability: Bool?
           let pushNotificationsFromFollowedOnly, canComment, suspended, canCloneLists: Bool?
           let canChangeAppIcon, canFilterActivity: Bool?
           let membershipDaysRemaining: Int?
           let membershipWillAutoRenewViaIAP: Bool?
           let hasActiveSubscription: Bool?
           let subscriptionType: String?
           let member: Member
           let campaigns: [String]?
           let adultContentPolicy: AdultContentPolicy?
           let posterMode: PosterMode?
           let posterModeOptions: [PosterMode]?
           let commentPolicy: CommentPolicy?
           let accountStatus: AccountStatus?
           let hideAds, showCustomPostersAds, canHaveCustomPosters: Bool?

           enum AdultContentPolicy: String, Codable {
               case always = "Always"
               case defaultPolicy = "Default"
           }

           enum PosterMode: String, Codable {
               case all = "All"
               case theirs = "Theirs"
               case yours = "Yours"
               case none = "None"
           }

           enum CommentPolicy: String, Codable {
               case anyone = "Anyone"
               case friends = "Friends"
               case you = "You"
           }

           enum AccountStatus: String, Codable {
               case active = "Active"
               case locked = "Locked"
               case memorialized = "Memorialized"
           }
    }
    
}
