//
//  NumberUtils.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/10/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation


class NumberUtils {
    
    static func convertFloatToString(value: Float!) -> String {
        if let value = value {
            return NSString(format: "%.1f $", value) as String
        } else {
            return ""
        }
    }
    
    static func convetStringToFloat(value: String!) -> Float? {
        if let value = value {
            return (value as NSString).floatValue
        } else {
            return nil
        }
    }
}
