//
//  SenderUser.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/26/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


struct SenderUser: Codable {
    var email: String
    var passwordConfirmation: String
    var birthday : String
    var address : String
    var firstName : String
    var lastName : String
    var phoneNumber : String
    var imageUrl : String
    var username : String
    var password : String
}
