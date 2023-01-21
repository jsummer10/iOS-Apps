//
//  DateUtil.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/21/23.
//

import Foundation

class DateUtil {
    static func chatTimestampFrom(date: Date?) -> String {
        guard date != nil else {
            return ""
        }
        
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        
        return df.string(from: date!)
    }
}
