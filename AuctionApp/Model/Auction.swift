//
//  Auction.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/6/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation
import UIKit


class Auction {
    
    //var image: UIImage
    var title: String
    var status: AuctionStatus
    var startPrice: Float
    var endPrice: Float!
    var createDate: Date
    var endDate: Date
    var description: String
    var imageUrl: String
    
    // Temp place
    var isLiked: Bool
    // Addition One-to-many fields: creator, purchasedBy,
    var raisers: [Raiser]!
    
    init(imageUrl: String, title: String, price: Float, description: String = "", createDate: Date = Date(),
         endDate: Date = Date(), endPrice: Float! = nil, status: AuctionStatus = .opened, isLiked: Bool = false) {
        self.imageUrl = imageUrl
        self.title = title
        self.startPrice = price
        self.endPrice = endPrice
        if endPrice == nil {
            self.endPrice = price
        }
        self.description = description
        self.createDate = createDate
        self.endDate = endDate
        self.status = status
        self.isLiked = isLiked
    }
}
