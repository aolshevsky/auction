//
//  Auction.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/6/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation
import UIKit


class Auction: Codable {
    
    //var image: UIImage
    var id: String
    var title: String
    var status: String
    var description: String
    
    var startPrice: Float
    var currentPrice: Float
    
    var createDate: Date
    var endDate: Date
    
    var imageUrl: String
    var isLiked: Bool
    
    var ownerId: String
    var raisers: [Raiser]!
    
    init(imageUrl: String, title: String, price: Float, currentPrice: Float! = nil, description: String = "", createDate: Date = Date(),
         endDate: Date = Date(), status: String = AuctionStatus.closed.rawValue, isLiked: Bool = false, raisers: [Raiser]! = nil, id: String = "", ownerId: String = "") {
        self.imageUrl = imageUrl
        self.id = id
        self.title = title
        self.startPrice = price
        self.currentPrice = currentPrice
        if currentPrice == nil {
            self.currentPrice = price
        }
        self.description = description
        self.createDate = createDate
        self.endDate = endDate
        self.status = status
        self.isLiked = isLiked
        self.raisers = raisers
        // TODO: Replace by login user
        self.ownerId = ownerId
    }
    
    func getStatus() -> AuctionStatus {
        return AuctionStatus(rawValue: self.status)!
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId
        case title = "name"
        case status
        case startPrice
        case currentPrice
        case imageUrl = "logoUrl"
        case createDate = "startDate"
        case endDate
        case description
        case raisers = "priceRaises"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.imageUrl, forKey: .imageUrl)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.startPrice, forKey: .startPrice)
        try container.encode(DateUtils.dateToString(date: self.createDate), forKey: .createDate)
        try container.encode(DateUtils.dateToString(date: self.endDate), forKey: .endDate)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.title = try container.decode(String.self, forKey: .title)
        self.startPrice = try container.decode(Float.self, forKey: .startPrice)
        self.currentPrice = try container.decode(Float.self, forKey: .currentPrice)
        self.description = try container.decode(String.self, forKey: .description)
        
        let decodeCreateDate = try container.decode(String.self, forKey: .createDate)
        self.createDate = DateUtils.getDateFormatter().date(from: decodeCreateDate)!
        let decodeEndDate = try container.decode(String.self, forKey: .endDate)
        self.endDate = DateUtils.getDateFormatter().date(from: decodeEndDate)!
        
        self.id = try container.decode(String.self, forKey: .id)
        self.ownerId = try container.decode(String.self, forKey: .ownerId)
        
        self.status = try container.decode(String.self, forKey: .status)
        self.raisers = try container.decode([Raiser].self, forKey: .raisers)
        // missing
        self.isLiked = false
    }
}
