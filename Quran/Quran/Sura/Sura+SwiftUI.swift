//
//  Sura+SwiftUI.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension Sura {
    
    @ViewBuilder
    func menu(favorite: Kollection?, pinned: Binding<Any?>) -> some View {
        if let favorite = favorite {
            StarButton(isStared: isElement(of: favorite), action: { [self] in
                withAnimation{
                    isElement(of: favorite) ? removeFromKollections(favorite) : addToKollections(favorite)
                }
            })
        }
        PinnedButton(isPinned: pinned.wrappedValue as? Sura == self, action: { [self] in
            withAnimation{
                pinned.wrappedValue = (pinned.wrappedValue as? Sura == self) ? nil : self
            }
        })
    }
    
    
}
