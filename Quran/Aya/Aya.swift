//
//  Aya.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

extension Aya {
    var number: Int  { (self.sura.ayas.toAyas.firstIndex(of: self) ?? 0) + 1 }
    var translation: String {
        return NSLocalizedString( "a\(self.id)", tableName: "ayas", comment: "Ayas trans")
    }
}


//MARK: - SwiftUI
extension Aya {
    
    func arabicTextView(lineLimit: Int = Int.max) -> some View {
        Text(self.text + "\u{FD3F}"+"\(self.number)".toArabicNumber+"\u{FD3E}")
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
    var iconColor: Color { self.isFavorite ? .yellow : Color("BGI")}
}


