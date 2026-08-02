//
//  UIApplication.swift
//  AlvisComponentsDemo
//
//  Created by kmsoft on 05/01/26.
//

import Foundation
import SwiftUI

extension UIApplication {

    static func topViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let root = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController
        else {
            return nil
        }

        return top(from: root)
    }

    private static func top(from vc: UIViewController) -> UIViewController {
        if let presented = vc.presentedViewController {
            return top(from: presented)
        }
        return vc
    }
}
