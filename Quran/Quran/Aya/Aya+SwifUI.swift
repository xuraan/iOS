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
                favorite.contains(object: self) ? favorite.removeFromAyas(self) : favorite.addToAyas(self)
            }
            print("\(pinned.contains(object: self))")
        })
        PinnedButton(isPinned: pinned.contains(object: self), action: { [self] in
            withAnimation{
                pinned.contains(object: self) ? pinned.removeFromAyas(self) : pinned.addToAyas(self)
            }
        })
    }
}

