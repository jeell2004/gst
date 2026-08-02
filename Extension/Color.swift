//
//  Color.swift
//  Habit Tracker
//
//  Created by KMSOFT on 22/01/25.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    init(_ r: Int, _ g: Int, _ b: Int, w: Int, highBlue: Bool = false) {
        
        func clamp(_ value: Int, _ minVal: Int, _ maxVal: Int) -> Int {
            return max(min(value, maxVal), minVal)
        }
        
        // Clamp inputs
        let rC = clamp(r, 0, 255)
        let gC = clamp(g, 0, 255)
        let bC = clamp(b, 0, 255)
        let wC = clamp(w, 0, 100)
        
        // Normalize to 0...1
        let rN = CGFloat(rC) / 255.0
        let gN = CGFloat(gC) / 255.0
        let bN = CGFloat(bC) / 255.0
        let wN = CGFloat(wC) / 100.0
        
        // Calibration
        let rCal: CGFloat = highBlue ? 0.8 : 1
        let gCal: CGFloat = 1.0
        let bCal: CGFloat = highBlue ? 1.5 : 1
        
        let wHalf = wN / 2.0
        
        let r2 = min(rN * rCal + wHalf, 1)
        let g2 = min(gN * gCal + wHalf, 1)
        let b2 = min(bN * bCal + wHalf, 1)

        self.init(
            red: Double(r2),
            green: Double(g2),
            blue: Double(b2)
        )
    }
    
    init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ w: CGFloat, highBlue: Bool = false) {
        
        let rCal: CGFloat = highBlue ? 0.8 : 1
        let gCal: CGFloat = 1
        let bCal: CGFloat = highBlue ? 1.5 : 1
        let w = w / 2
        
        let r2 = min(r * rCal + w, 1)
        let g2 = min(g * gCal + w, 1)
        let b2 = min(b * bCal + w, 1)

        self.init(
                red: Double(r2),
                green: Double(g2),
                blue: Double(b2)
            )
    }
    
    func toHex() -> String? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
    
    func toRGBW() -> (r: CGFloat, g: CGFloat, b: CGFloat, w: CGFloat) {
        
        let uiColor = UIColor(self)
        
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a: CGFloat = 0
        
        uiColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a)
        
        let rCal: CGFloat = 1.0
        let gCal: CGFloat = 1.0
        let bCal: CGFloat = 1.0
        
        func clamp(_ x: CGFloat) -> CGFloat {
            return min(max(x, 0), 1)
        }
        
        let epsilon: CGFloat = 0.001
        
        // Detect near-equal channels
        let isGray = abs(r2 - g2) < epsilon && abs(g2 - b2) < epsilon
        
        // Step 1: Estimate white
        let w2 = min(r2, g2, b2)
        
        // Step 2: Recover RGB
        var r = (r2 - w2) / rCal
        var g = (g2 - w2) / gCal
        var b = (b2 - w2) / bCal
        
        // Step 3: Blue clipping fix (avoid gray/white)
        if !isGray && abs(b2 - 1.0) < epsilon && b2 >= r2 && b2 >= g2 {
            b = 1.0
        }
        
        // Step 4: Clamp RGB
        r = clamp(r)
        g = clamp(g)
        b = clamp(b)
        
        // Step 5: Compute white
        var w = clamp(w2 * 2)
        
        // ✅ For gray/white → keep RGB ALSO
        if isGray {
            r = clamp(r2)
            g = clamp(g2)
            b = clamp(b2)
            w = clamp(r2 * 2)
        }
        
        return (r, g, b, w)
    }
    
    func toRGBW255() -> (r: Int, g: Int, b: Int, w: Int) {
        let result = self.toRGBW()
        
        func clamp01(_ x: CGFloat) -> CGFloat {
            return min(max(x, 0), 1)
        }
        
        let r255 = Int((clamp01(result.r) * 255).rounded())
        let g255 = Int((clamp01(result.g) * 255).rounded())
        let b255 = Int((clamp01(result.b) * 255).rounded())
        
        let w100 = Int((clamp01(result.w) * 100).rounded())
        
        return (r255, g255, b255, w100)
    }
    
    static func toRGBW255(r: CGFloat, g: CGFloat, b: CGFloat, w: CGFloat) -> (r: Int, g: Int, b: Int, w: Int) {
        func clamp01(_ x: CGFloat) -> CGFloat {
            return min(max(x, 0), 1)
        }
        
        let r255 = Int((clamp01(r) * 255).rounded())
        let g255 = Int((clamp01(g) * 255).rounded())
        let b255 = Int((clamp01(b) * 255).rounded())
        
        let w100 = Int((clamp01(w) * 100).rounded())
        
        return (r255, g255, b255, w100)
    }
    
    static func toRGBWFraction(r: Int, g: Int, b: Int, w: Int) -> (r: CGFloat, g: CGFloat, b: CGFloat, w: CGFloat) {
        
        func clamp(_ value: Int, _ minVal: Int, _ maxVal: Int) -> Int {
            return max(min(value, maxVal), minVal)
        }
        
        // Clamp inputs
        let rC = clamp(r, 0, 255)
        let gC = clamp(g, 0, 255)
        let bC = clamp(b, 0, 255)
        let wC = clamp(w, 0, 100)
        
        // Convert back to 0...1
        let rN = CGFloat(rC) / 255.0
        let gN = CGFloat(gC) / 255.0
        let bN = CGFloat(bC) / 255.0
        let wN = CGFloat(wC) / 100.0
        
        return (rN, gN, bN, wN)
    }
    
    static func fromHSB(hue: Double) -> Color {
        Color(hue: hue, saturation: 1, brightness: 1)
    }
    
    static func colorHexFromHue(
        _ hue: Double,
        gradientColors: [Color]
    ) -> String {
        let color = self.colorFromHue(hue, gradientColors: gradientColors)
        return color.toHex() ?? "#FFFFFF"
    }
    
    static func colorFromHue(
        _ hue: Double,
        gradientColors: [Color]
    ) -> Color {
        let t = min(max(hue, 0), 1)
        
        let scaled = t * Double(gradientColors.count - 1)
        let index = Int(scaled)
        let fraction = scaled - Double(index)
        
        if index >= gradientColors.count - 1 {
            return gradientColors.last!
        }
        
        return Color.interpolate(
            from: gradientColors[index],
            to: gradientColors[index + 1],
            fraction: fraction
        )
    }
    
    static func interpolate(
        from: Color,
        to: Color,
        fraction: Double
    ) -> Color {
        let f = min(max(fraction, 0), 1)
        
        let r1 = from.components.r
        let g1 = from.components.g
        let b1 = from.components.b
        
        let r2 = to.components.r
        let g2 = to.components.g
        let b2 = to.components.b
        
        return Color(
            red: r1 + (r2 - r1) * f,
            green: g1 + (g2 - g1) * f,
            blue: b1 + (b2 - b1) * f
        )
    }
    
    var components: (r: Double, g: Double, b: Double) {
#if os(iOS)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b))
#else
        return (0, 0, 0)
#endif
    }
    
    var components255: (r: Int, g: Int, b: Int) {
    #if os(iOS)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (
            Int(round(r * 255)),
            Int(round(g * 255)),
            Int(round(b * 255))
        )
    #else
        return (0, 0, 0)
    #endif
    }
    
    func isWhite() -> Bool {
        let r = self.components255.r
        let g = self.components255.g
        let b = self.components255.b
        return (r == 255 && g == 255 && b == 255)
    }
    
    func isNearWhite(threshold: CGFloat = 0.9) -> Bool {
        let uiColor = UIColor(self)
        return uiColor.isNearWhite(threshold: threshold)
    }
}

extension Color {
    static func temperatureFromHue(_ hue: CGFloat) -> Int {
        let minTemp: CGFloat = 2700
        let maxTemp: CGFloat = 6400

        let clampedHue = min(max(hue, 0), 1)
        let temperature = minTemp + clampedHue * (maxTemp - minTemp)

        return Int(temperature.rounded())
    }

    static func hueFromTemperature(_ temperature: CGFloat) -> CGFloat {
        let minTemp: CGFloat = 2700
        let maxTemp: CGFloat = 6400

        let clampedTemp = min(max(temperature, minTemp), maxTemp)

        let hue = (clampedTemp - minTemp) / (maxTemp - minTemp)

        return min(max(hue, 0), 1)
    }
}

extension Color {
    var mainBackgroundBlack: Color {
        return Color("background_black")
    }
}
