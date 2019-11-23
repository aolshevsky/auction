//
//  UserChangeInfo.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/23/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


protocol UserChangeInfoDelegate: class {
    func updateUserInfo()
}

protocol BetVCDelegate: class {
    func setupInfoData()
}
