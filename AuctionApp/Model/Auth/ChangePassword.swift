//
//  ChangePassword.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/23/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


struct ChangePassword: Codable {
    var currentPassword: String
    var newPassword: String
    var newPasswordConfirmation: String
}
