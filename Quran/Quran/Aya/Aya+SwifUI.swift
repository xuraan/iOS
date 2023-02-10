//
//  Aya+SwifUI.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension Aya {
    @ViewBuilder
    func menu(favorite: Kollection, pinned: Kollection) -> some View {
        StarButton(isStared: favorite.contains(object: self), action: { [self] in
            withAnimation{
                isElement(of: favorite) ? removeFromKollections(favorite) : addToKollections(favorite)
            }
        })
        PinnedButton(isPinned: pinned.contains(object: self), action: { [self] in
            withAnimation{
                isElement(of: pinned) ? removeFromKollections(pinned) : addToKollections(pinned)
            }
        })
    }
}

