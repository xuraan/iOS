//
//  Sura+SwiftUI.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension Sura {
    
    @ViewBuilder
    func menu(favorite: Kollection, pinned: Kollection) -> some View {
        
        StarButton(isStared: isElement(of: favorite), action: { [self] in
            withAnimation{
                isElement(of: favorite) ? removeFromKollections(favorite) : addToKollections(favorite)
            }
        })
        PinnedButton(isPinned: isElement(of: pinned), action: { [self] in
            withAnimation{
                isElement(of: pinned) ? removeFromKollections(pinned) : addToKollections(pinned)
            }
        })
    }
    
    
}
