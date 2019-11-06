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
    var isStar: Bool
    
    init(image: UIImage, title: String, price: Int, isStar: Bool) {
        self.image = image
        self.title = title
        self.price = price
        self.isStar = isStar
    }
}
