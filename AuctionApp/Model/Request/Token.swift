//
//  Token.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/21/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


struct Token: Decodable {
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
