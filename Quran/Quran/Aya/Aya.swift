//
//  Aya.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI


extension Aya {
    var number: Int  { (self.sura.ayas.ayas.firstIndex(of: self) ?? 0) + 1 }
    var translation: String { NSLocalizedString( "a\(self.id)", tableName: "ayas", comment: "Ayas trans") }
    func isElement(of kollection: Kollection?) -> Bool {
        if let kollection = kollection {
            return self.kollections.contains(kollection)
        }
        return false
    }
}

//MARK: - SwiftUI
extension Aya {
    func arabicTextView(lineLimit: Int = Int.max) -> some View {
        Text(self.text + "\u{FD3F}"+"\(self.number)".toArabicNumeral+"\u{FD3E}")
            .lineLimit(lineLimit)
            .frame(maxWidth: .infinity, alignment: .leading)
            .environment(\.layoutDirection, .rightToLeft)
    }
    func transTextView(lineLimit: Int = Int.max) -> some View {
        HStack{
            Text("\(self.number). ") +
            Text(self.translation)
        }
        .lineLimit(lineLimit)
        .foregroundColor(.secondary)
        .opacity(0.7)
        .frame(maxWidth: .infinity, alignment: .leading)
        .environment(\.layoutDirection, .leftToRight)
    }
}


