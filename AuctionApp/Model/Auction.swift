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
    
    var image: UIImage
    var title: String
    var price: Int
    var raisers: [Raiser]!
    var createDate: Date!
    var description: String
    var isStar: Bool
    
    init(image: UIImage, title: String, price: Int, description: String = "", isStar: Bool) {
        self.image = image
        self.title = title
        self.price = price
        self.description = description
        self.isStar = isStar
    }
}
