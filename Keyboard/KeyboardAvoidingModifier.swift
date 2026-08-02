//
//  KeyboardAvoidingModifier.swift
//  Inventory Management
//
//  Created by kmsoft on 16/05/26.
//

import SwiftUI
import Combine

struct KeyboardAvoidingModifier: ViewModifier {
    
    let extraBottomPadding: CGFloat
    var onKeyboardHeightChange: ((CGFloat) -> Void)?
    
    @State private var keyboardHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        
        content
            .padding(.bottom, keyboardHeight)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .animation(.easeOut(duration: 0.25), value: keyboardHeight)
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIResponder.keyboardWillChangeFrameNotification
                )
            ) { notification in
                
                guard
                    let frame = notification.userInfo?[
                        UIResponder.keyboardFrameEndUserInfoKey
                    ] as? CGRect
                else { return }
                
                let bounds = UIDevice.current.deviceBounds()
                let screenHeight = bounds.height
                let screenBottom = UIDevice.current.safeAreaInsets()?.bottom ?? 0
                let newHeight: CGFloat
                
                if frame.origin.y >= screenHeight {
                    newHeight = 0
                } else {
                    newHeight = screenHeight - frame.origin.y - screenBottom + extraBottomPadding
                }
                
                keyboardHeight = newHeight
                onKeyboardHeightChange?(newHeight)
            }
    }
}

extension View {
    
    func keyboardAvoiding(
        extraBottomPadding: CGFloat = 0,
        onKeyboardHeightChange: ((CGFloat) -> Void)? = nil
    ) -> some View {
        modifier(
            KeyboardAvoidingModifier(
                extraBottomPadding: extraBottomPadding,
                onKeyboardHeightChange: onKeyboardHeightChange
            )
        )
    }
}
