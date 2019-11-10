//
//  StatusEnum.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/10/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


enum AuctionStatus: String {
    case active = "Active", blocked = "Blocked", completed = "Completed"
    
    static let allValues = [active, blocked, completed]
}
