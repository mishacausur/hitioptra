//
//  ColorExtension.swift
//  Networker
//
//  Created by Misha Causur on 28.10.2021.
//

import Foundation
import UIKit

extension UIColor {
    
    var accessibleFontColor: UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        UIColor().getRed(&red, green: &green, blue: &blue, alpha: nil)

        return isLightColor(red: red, green: green, blue: blue) ? .black : .white
    }
    
    private func isLightColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> Bool {
        let lightRed = red > 0.65
        let lightGreen = green > 0.65
        let lightBlue = blue > 0.65

        let lightness = [lightRed, lightGreen, lightBlue].reduce(0) { $1 ? $0 + 1 : $0 }
        return lightness >= 2
    }
}
