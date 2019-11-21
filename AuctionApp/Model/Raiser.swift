//
//  Raiser.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/7/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


class Raiser: Codable {
    
    var userId: String
    var startPrice: Int
    var endPrice: Int
    var date: Date
    
    init(startPrice: Int, endPrice: Int, date: Date) {
        self.startPrice = startPrice
        self.endPrice = endPrice
        self.date = date
        self.userId = DataSource.shared.currentUser.id
    }
    
    func getCount() -> Int {
        return self.startPrice - self.endPrice
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "raisedUserId"
        case startPrice
        case endPrice
        case date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.startPrice = try container.decode(Int.self, forKey: .startPrice)
        self.endPrice = try container.decode(Int.self, forKey: .endPrice)
        let decodeDate = try container.decode(String.self, forKey: .date)
        self.date = DateUtils.getDateFormatter().date(from: decodeDate)!
    }
}
