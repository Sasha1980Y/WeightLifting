//
//  Helper.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 3/1/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit
import Foundation

class Helper {
    static let shared = Helper()
    
    func shortFormatForDate(date: Date) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        //formatter.locale
        let dateStr = formatter.string(from: date)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let dateOut = formatter.date(from: dateStr) {
            return dateOut
        }
        return nil
    }
    
    
}

