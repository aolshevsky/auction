//
//  Raiser.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/7/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


class Raiser {
    
    var user: User
    var count: Int
    var date: Date
    
    init(user: User, count: Int, date: Date) {
        self.user = user
        self.count = count
        self.date = date
    }
    
}
