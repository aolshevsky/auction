//
//  DateUtils.swift
//  AuctionApp
//
//  Created by Alexey Olshevsky on 11/10/19.
//  Copyright © 2019 Alexey Olshevsky. All rights reserved.
//

import Foundation

class DateUtils {
    private static func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static func dateToString(date: Date!) -> String {
        if let date = date {
            return getDateFormatter().string(from: date)
        } else {
            return ""
        }
    }
}

