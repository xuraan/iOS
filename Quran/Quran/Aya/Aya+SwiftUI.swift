//
//  Aya+SwiftUI.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-18.
//

import SwiftUI

extension Aya {
    func arabicTextView(lineLimit: Int = Int.max) -> some View {
        Text(textWithEndAya)
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
