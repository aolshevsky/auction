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
    var startPrice: Float
    var endPrice: Float
    var date: Date
    
    init(startPrice: Float, endPrice: Float, date: Date) {
        self.startPrice = startPrice
        self.endPrice = endPrice
        self.date = date
        self.userId = DataSource.shared.currentUser.id
    }
    
    func getCount() -> Float {
        return self.endPrice - self.startPrice
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
        self.startPrice = try container.decode(Float.self, forKey: .startPrice)
        self.endPrice = try container.decode(Float.self, forKey: .endPrice)
        let decodeDate = try container.decode(String.self, forKey: .date)
        self.date = DateUtils.getDateFormatter().date(from: decodeDate)!
    }
}
