//
//  KeyboardObserver.swift
//  AlvisApp
//
//  Created by KMSOFT on 23/01/26.
//


import SwiftUI
import Combine

final class KeyboardObserver: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        let willChangeFrame = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)

        Publishers.Merge3(willShow, willHide, willChangeFrame)
            .receive(on: RunLoop.main)
            .sink { notification in
                if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = frame.height
                } else {
                    self.keyboardHeight = 0
                }
            }
            .store(in: &cancellables)
    }
}
