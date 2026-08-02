//
//  View.swift
//  AlvisComponentsDemo
//
//  Created by kmsoft on 29/12/25.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
    
    @ViewBuilder
    func applyToolbarTitleDisplayMode() -> some View {
        if #available(iOS 17.0, *) {
            self.toolbarTitleDisplayMode(.inline)
        } else {
            self.navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    func applyDisplaywiseBottomPadding(padding: CGFloat = 16) -> some View {
        self.padding(.bottom, UIDevice.current.hasFullDisplay() ? 0 : padding)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func border(
        _ color: Color,
        width: CGFloat,
        edges: [Edge]
    ) -> some View {
        overlay(
            GeometryReader { geo in
                ZStack {
                    if edges.contains(.top) {
                        Rectangle()
                            .fill(color)
                            .frame(height: width)
                            .position(x: geo.size.width / 2, y: width / 2)
                    }
                    
                    if edges.contains(.bottom) {
                        Rectangle()
                            .fill(color)
                            .frame(height: width)
                            .position(x: geo.size.width / 2, y: geo.size.height - width / 2)
                    }
                    
                    if edges.contains(.leading) {
                        Rectangle()
                            .fill(color)
                            .frame(width: width)
                            .position(x: width / 2, y: geo.size.height / 2)
                    }
                    
                    if edges.contains(.trailing) {
                        Rectangle()
                            .fill(color)
                            .frame(width: width)
                            .position(x: geo.size.width - width / 2, y: geo.size.height / 2)
                    }
                }
            }
        )
    }
    
    @ViewBuilder
    func numericTextTransitionIfAvailable(value: Double) -> some View {
        if #available(iOS 17, *) {
            self.contentTransition(.numericText(value: value))
        } else {
            self
        }
    }
    
    @ViewBuilder
    func transform(
        @ViewBuilder _ content: (Self) -> some View
    ) -> some View {
        content(self)
    }
    
    @ViewBuilder
    func onChangeOfURL(_ url: URL?, completion: @escaping ((URL?) -> ())) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: url) { oldValue, newValue in
                completion(newValue)
            }
        } else {
            self.onChange(of: url) { newValue in
                completion(newValue)
            }
        }
    }
    
    @ViewBuilder
    func onChangeOfString(_ string: String, completion: @escaping ((String) -> ())) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: string) { oldValue, newValue in
                completion(newValue)
            }
        } else {
            self.onChange(of: string) { newValue in
                completion(newValue)
            }
        }
    }
    
    @ViewBuilder
    func onChangeOfDouble(_ double: Double, completion: @escaping ((Double) -> ())) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: double) { oldValue, newValue in
                completion(newValue)
            }
        } else {
            self.onChange(of: double) { newValue in
                completion(newValue)
            }
        }
    }
    
    @ViewBuilder
    func onChangeOfCGFloat(_ cgFloat: CGFloat, completion: @escaping ((CGFloat) -> ())) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: cgFloat) { oldValue, newValue in
                completion(newValue)
            }
        } else {
            self.onChange(of: cgFloat) { newValue in
                completion(newValue)
            }
        }
    }
    
    @ViewBuilder
    func onChangeOfBool(_ bool: Bool, completion: @escaping ((Bool) -> ())) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: bool) { oldValue, newValue in
                completion(newValue)
            }
        } else {
            self.onChange(of: bool) { newValue in
                completion(newValue)
            }
        }
    }
    
    @ViewBuilder
    func onChangeOfColor(_ value: Color, completion: @escaping ((Color) -> ())) -> some View {
        if #available(iOS 17.0, *) {
            self.onChange(of: value) { oldValue, newValue in
                completion(newValue)
            }
        } else {
            self.onChange(of: value) { newValue in
                completion(newValue)
            }
        }
    }
    
    @ViewBuilder func scaledPopUp<Content: View>(isPresented: Binding<Bool>, horizontalPadding: CGFloat = 30, bgTapDismissEnabled: Bool = true, @ViewBuilder content: @escaping () -> Content ) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        if bgTapDismissEnabled {
                            isPresented.wrappedValue = false
                        }
                    }
                    .zIndex(998)
                
                content()
                    .padding(.horizontal, horizontalPadding)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(999)
            }
        }
        .animation(.easeOut(duration: 0.25), value: isPresented.wrappedValue)
    }
    
    
    @ViewBuilder
    func bottomUpPopUp<Content: View>(isPresented: Binding<Bool>, horizontalPadding: CGFloat = 30, bgTapDismissEnabled: Bool = true, bgTapDismissCompletion: (() -> ())? = nil, @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(998)
                    .transform({
                        if bgTapDismissEnabled {
                            $0
                                .onTapGesture {
                                    bgTapDismissCompletion?()
                                    isPresented.wrappedValue = false
                                }
                        } else {
                            $0
                        }
                    })
                
                content()
                    .padding(.horizontal, horizontalPadding)
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        )
                    )
                    .zIndex(999)
            }
        }
        .animation(.easeOut(duration: 0.25), value: isPresented.wrappedValue)
    }
    
    @ViewBuilder
    func topDownPopUp<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        isPresented.wrappedValue = false
                    }
                    .zIndex(998)
                
                content()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        )
                    )
                    .zIndex(999)
            }
        }
        .animation(.easeOut(duration: 0.25), value: isPresented.wrappedValue)
    }
    
    @ViewBuilder
    func topSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self
            
            Color.black
                .opacity(isPresented.wrappedValue ? 0.6 : 0)
                .ignoresSafeArea()
                .allowsHitTesting(isPresented.wrappedValue)
                .onTapGesture {
                        isPresented.wrappedValue = false
                }
                .animation(.easeInOut(duration: 0.25), value: isPresented.wrappedValue)
                .zIndex(998)
            
            content()
                .offset(y: isPresented.wrappedValue ? 0 : -1000)   // 🔑 KEY
                .opacity(isPresented.wrappedValue ? 1 : 0)
                .animation(.easeInOut(duration: 0.25), value: isPresented.wrappedValue)
                .zIndex(999)
        }
        .animation(.easeOut(duration: 0.25), value: isPresented.wrappedValue)
    }
    
    @ViewBuilder
    func trailingSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack(alignment: .trailing) {
            self
            
            Color.black
                .opacity(isPresented.wrappedValue ? 0.6 : 0)
                .ignoresSafeArea()
                .allowsHitTesting(isPresented.wrappedValue)
                .onTapGesture {
                        isPresented.wrappedValue = false
                }
                .animation(.easeInOut(duration: 0.25), value: isPresented.wrappedValue)
                .zIndex(998)
            
            content()
                .offset(x: isPresented.wrappedValue ? 0 : 2000)   // 🔑 KEY
                .opacity(isPresented.wrappedValue ? 1 : 0)
                .animation(.easeInOut(duration: 0.25), value: isPresented.wrappedValue)
                .zIndex(999)
        }
        .animation(.easeOut(duration: 0.25), value: isPresented.wrappedValue)
    }
    
    @ViewBuilder
    func dropDownSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        
        self.overlay {
            if isPresented.wrappedValue {
                ZStack(alignment: .top) {
                    Color.clear
                        .contentShape(Rectangle())
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .onTapGesture {
                            isPresented.wrappedValue = false
                        }
                    
                    content()
                        .zIndex(1)
                        .scaleEffect(1)
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: isPresented.wrappedValue)
    }
    
    @ViewBuilder
    func bottomSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .overlay {
                ZStack(alignment: .bottom) {
                    if isPresented.wrappedValue {
                        Color.black
                            .opacity(0.6)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isPresented.wrappedValue = false
                            }
                            .transition(.opacity)
                        
                        content()
                            .transition(
                                .move(edge: .bottom)
                                .combined(with: .opacity)
                            )
                    }
                }
                .zIndex(999)
                .animation(.easeOut(duration: 0.25), value: isPresented.wrappedValue)
                .allowsHitTesting(isPresented.wrappedValue)
            }
    }
}
