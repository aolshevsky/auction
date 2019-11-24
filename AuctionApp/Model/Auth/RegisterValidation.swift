//
//  RegisterValidation.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/25/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


struct RegisterValidation: Codable {
    var username: String
    var password: String
    var passwordConfirmation: String
}
