//
//  Aya+SwifUI.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

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
