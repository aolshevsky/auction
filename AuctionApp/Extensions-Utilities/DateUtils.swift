//
//  DateUtils.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/10/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation

class DateUtils {
    static func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static func get8601DateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }
    
    static func dateToString(date: Date?, formatter: () -> DateFormatter = getDateFormatter) -> String {
        if let date = date {
            return formatter().string(from: date)
        } else {
            return ""
        }
    }
}

