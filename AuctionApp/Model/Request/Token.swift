//
//  Token.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/21/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


struct Token: Codable {
    var token: String
    
    static func setupToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: DefaultsKeys.token)
    }
}
