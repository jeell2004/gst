//
//  RoundedCorner.swift
//  AlvisApp
//
//  Created by kmsoft on 20/01/26.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
    
    @ViewBuilder
    func colouredBackgroundWithBorder(cornerRadius: CGFloat,
                                      backgroundColor: Color,
                                      borderColor: Color = Color(hex: "#D9D9D9").opacity(0.2),
                                      borderWidth: CGFloat = 0.5) -> some View {
        self.background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            borderColor,
                            lineWidth: borderWidth
                        )
                )
        )
    }
}
