//
//  UIImage.swift
//  AlvisApp
//
//  Created by kmsoft on 09/04/26.
//

import Foundation
import SwiftUI

extension UIImage {
    func resizedImageIfNeeded(maxDimension: CGFloat) -> UIImage {
        let width = self.size.width
        let height = self.size.height
        
        // If both dimensions are within limit, return as-is
        if width <= maxDimension && height <= maxDimension {
            return self
        }
        
        let scaleFactor: CGFloat
        
        if width > height {
            // Width is the larger side
            scaleFactor = maxDimension / width
        } else {
            // Height is the larger side
            scaleFactor = maxDimension / height
        }
        
        let newSize = CGSize(
            width: width * scaleFactor,
            height: height * scaleFactor
        )
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
