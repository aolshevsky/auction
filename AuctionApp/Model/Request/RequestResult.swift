//
//  RequestResult.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/20/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


struct RequestResult<T: Decodable>: Decodable {
    var code: Int?
    var message: String
    var status: String
    var result: T?

    init(code: Int?, message: String, status: String, result: T?) {
        self.code = code
        self.message = message
        self.status = status
        self.result = result
    }
}
