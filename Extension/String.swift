//
//  String.swift
//  buddyUpppp
//
//  Created by KMSOFT on 07/07/21.
//

import Foundation
import UIKit

extension String {
    var trim: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var isRemoteUrlString: Bool {
        return self.hasPrefix("http://") || self.hasPrefix("https://")
    }
    
    func getDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func getISODate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]
        return formatter.date(from: self)
    }
   
    func isValidEmail() -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidMobileNumber() -> Bool {
        let mobileRegex = #"^[6-9][0-9]{9}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        return predicate.evaluate(with: self)
    }
    
    func isValidOTP(digits: Int = 6) -> Bool {
        let otpRegex = "^\(String(repeating: "[0-9]", count: digits))$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", otpRegex)
        return predicate.evaluate(with: self)
    }
    
    func getLocalString(localizable: String? = nil) -> String {
        let language = localizable ?? UserDefaultHelper.shared.language ?? "en"
        // Update bundle if needed
        if language != UserDefaultHelper.shared.language {
            LocalizationHelper.setLanguage(language)
        }
        return LocalizationHelper.localizedString(for: self)
    }
}
