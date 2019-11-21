//
//  Raiser.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/7/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


class Raiser: Decodable {
    
    var userId: String
    var startPrice: Int
    var endPrice: Int
    var date: Date
    
    init(user: User, startPrice: Int, endPrice: Int, date: Date) {
        self.startPrice = startPrice
        self.endPrice = endPrice
        self.date = date
        self.userId = user.id
    }
    
    func getCount() -> Int {
        return self.startPrice - self.endPrice
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "raisedUserId"
        case startPrice
        case endPrice
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.startPrice = try container.decode(Int.self, forKey: .startPrice)
        self.endPrice = try container.decode(Int.self, forKey: .endPrice)
        // missing
        self.date = Date()
    }
}
