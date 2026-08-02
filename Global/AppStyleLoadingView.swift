//
//  AppStyleLoadingView.swift
//  GST Verify_iOS
//
//  Created by KMSOFT on 09/06/26.
//

import SwiftUI

struct AppStyleLoadingView: View {
    var tint: Color = .blue
    var scaleEffect: CGFloat = UIDevice.current.isIpad ? 1.25 : 1
    
    var body: some View {
        Group {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(self.tint)
                .scaleEffect(self.scaleEffect)
        }
    }
}

#Preview {
    AppStyleLoadingView()
}
