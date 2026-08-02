//
//  Device.swift
//  AlvisApp
//
//  Created by kmsoft on 20/01/26.
//

import Foundation
import SwiftUI

extension UIDevice {
    func hasFullDisplay() -> Bool {
        guard let window = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first(where: { $0.isKeyWindow }) else {
            return false
        }

        return window.safeAreaInsets.bottom > 0
    }
    
    func deviceBounds() -> CGRect {
        guard let window = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first(where: { $0.isKeyWindow }) else {
            return .zero
        }

        return window.bounds
    }
    
    
    func safeAreaInsets() -> UIEdgeInsets? {
        guard let window = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first(where: { $0.isKeyWindow }) else {
            return .zero
        }

        return window.safeAreaInsets
    }
    
    var modelString: String {
        return "\(UIDevice.current.model) (\(UIDevice.current.systemVersion))"
    }
    
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
