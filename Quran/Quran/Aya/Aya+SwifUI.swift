//
//  Aya+SwifUI.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

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

extension Aya {
    @ViewBuilder
    func menu(favorite: Kollection?, pinned: Binding<Any?>) -> some View {
        if let favorite = favorite {
            StarButton(isStared: favorite.contains(object: self), action: { [self] in
                withAnimation{
                    isElement(of: favorite) ? removeFromKollections(favorite) : addToKollections(favorite)
                }
            })
        }
        
        PinnedButton(isPinned: pinned.wrappedValue as? Aya == self, action: { [self] in
            withAnimation{
                pinned.wrappedValue = (pinned.wrappedValue as? Aya == self) ? nil : self
            }
        })
    }
}
