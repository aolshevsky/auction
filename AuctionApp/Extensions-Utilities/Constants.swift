//
//  Constants.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/6/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import UIKit

struct Images {
    static let star = UIImage(named: "star")
    static let emptyStar = UIImage(named: "empty_star")
    static let baseUser = UIImage(named: "base_user")
    static let man = UIImage(named: "man")
    static let man1 = UIImage(named: "man_1")
    static let man2 = UIImage(named: "man_2")
    static let userBaseImages = Set(arrayLiteral: Images.man, Images.man1, Images.man2)
}

struct DbConstant {
    static let auctionDatabasePath: String = "auctions/"
    static let userDatabasePath: String = "users/"
    static let imageType: String = ".png"
    static func getAuctionPath(id: String) -> String { return DbConstant.auctionDatabasePath + id + DbConstant.imageType}
    static func getUserPath(id: String) -> String { return DbConstant.userDatabasePath + id + DbConstant.imageType}
}

struct UserConstant {
    static let minAge: Int = 12
    static let maxBalanceBet: Int = 5000
    static let minBalanceBet: Int = 5
}
