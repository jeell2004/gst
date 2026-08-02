//
//  LinearGradient.swift
//  Guru_iOS
//
//  Created by kmsoft on 29/05/26.
//

import SwiftUI

extension LinearGradient {

    static var headerGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(color: Color(hex: "#FFF363"), location: 0.0),
                .init(color: Color(hex: "#FDAE0B"), location: 1.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static func verticalFade(
        color: Color,
        startOpacity: Double = 1,
        endOpacity: Double = 0
    ) -> LinearGradient {
        LinearGradient(
            colors: [
                color.opacity(startOpacity),
                color.opacity(endOpacity)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static func horizontalFade(
        color: Color,
        startOpacity: Double = 1,
        endOpacity: Double = 0
    ) -> LinearGradient {
        LinearGradient(
            colors: [
                color.opacity(startOpacity),
                color.opacity(endOpacity)
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
