//
//  String.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-19.
//

import SwiftUI

extension String {
    var isNumeric: Bool { return Int(self) != nil}
    var isArabicNumeral: Bool {
        return self.range(
            of: "^[٠-٩]*$",
            options: .regularExpression) != nil
    }
    var isArabic: Bool {
            return self.range(
                of: "^[.:\" ء-ي]+$", // 1
                options: .regularExpression) != nil
        }
    var toArabicNumeral: String {
        let arabicNumerals = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]
        var result = ""
        for char in self {
            if let intValue = Int(String(char)) {
                result += arabicNumerals[intValue]
            } else {
                result += String(char)
            }
        }
        return result
    }
}

//func format(stringList: [String] = []) -> AttributedString {
//    var ayaFormat = AttributedString(self)
//    let ayaFormat1 = AttributedString(self.lowercased())
//    for str in stringList {
//        if let range = ayaFormat1.range(of: str.lowercased()) {
//            ayaFormat[range].foregroundColor = .red.opacity(0.8)
//        }
//    }
//    return ayaFormat
//}
//func format(form string: String, stringList: [String] = []) -> AttributedString {
//    var ayaFormat = AttributedString(self)
//    let ayaFormat1 = AttributedString(string.lowercased())
//    for str in stringList {
//        if let range = ayaFormat1.range(of: str.lowercased()) {
//            ayaFormat[range].foregroundColor = .red
//        }
//    }
//    return ayaFormat
//}
