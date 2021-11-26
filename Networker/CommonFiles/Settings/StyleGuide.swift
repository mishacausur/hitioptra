//
//  StyleGuide.swift
//  Networker
//
//  Created by Misha Causur on 26.11.2021.
//

import UIKit

// MARK: - Colors

enum Color {
  
    case background
    case darkViolet
    case error
    case profileButton
    
    static func setColor(_ color: Color) -> UIColor {
        switch color {
        case .background:
            return UIColor(named: "BackgroundViolet")!
        case .darkViolet:
            return UIColor(named: "DarkViolet")!
        case .error:
            return UIColor(named: "ErrorRed")!
        case .profileButton:
            return UIColor(named: "profileButton")!
        }
    }
}

// MARK: - Fonts

enum Font {
    
    case regular
    case light
    case semibold
    
    static func setFont(_ font: Font, _ size: CGFloat) -> UIFont {
        switch font {
        case .regular:
            return UIFont(name: "VenrynSans-Regular", size: size)!
        case .light:
            return UIFont(name: "VenrynSans-Light", size: size)!
        case .semibold:
            return UIFont(name: "VenrynSans-SemiBold", size: size)!
        }
    }
}
