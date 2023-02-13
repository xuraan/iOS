//
//  Color.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI


extension Color {
    
    static func favorite(_ condition: Bool) -> Color {
        condition ? .yellow : Color("BGI")
    }
    
    var hex: String { UIColor(self).hex }
    
    init(hex: String){
        self.init(uiColor: UIColor(hex: hex))
    }
    
}

extension UIColor {
    
    
    
    var hex: String {
            
            guard let components = self.cgColor.components, components.count >= 3 else {
                return "000"
            }
            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            var a = Float(1.0)

            if components.count >= 4 {
                a = Float(components[3])
            }

            if a != Float(1.0) {
                return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
            } else {
                return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
            }
        }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }

    
}

