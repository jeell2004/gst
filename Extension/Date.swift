//
//  Date.swift
//  AlvisApp
//
//  Created by kmsoft on 20/01/26.
//

import Foundation

extension Date {
    var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    var weekDay: Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: self)
    }
    
    var weekOfMonth: Int {
        let calendar = Calendar.current
        return calendar.component(.weekOfMonth, from: self)
    }
    
    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    var toTimeString: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "hh:mm a"
        return dateFormat.string(from: self)
    }
    
    var toTimeStringHHMMSS: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: self)
    }
    
    var toStringDDMMYYYY: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        return dateFormat.string(from: self)
    }
    
    var toStringDDMMYYYYDASH: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        return dateFormat.string(from: self)
    }
    
    func toISOString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]
        return formatter.string(from: self)
    }
    
    func toString(with format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
    
    func merge(date: Date) -> Date {
        let calendar = Calendar.current
        
        let timeComp = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        return calendar.date(bySettingHour: timeComp.hour ?? 0,
                             minute: timeComp.minute ?? 0,
                             second: timeComp.second ?? 0,
                             of: date) ?? date
    }
    
    func isPastDate() -> Bool {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self) < calendar.startOfDay(for: Date())
    }
    
    func isToday() -> Bool {
        Calendar.current.isDateInToday(self)
    }
}
