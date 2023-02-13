//
//  Sofha+SwiftUI.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

//MARK: - Image
extension Sofha {
    func image (colorScheme: ColorScheme?)->Image {
        Image("\(self.id)")
            .resizable()
            .renderingMode(colorScheme == .dark ? .template : .original)
    }
}

extension Sofha {
    
    @ViewBuilder
    func menu(favorite: Kollection?, pinned: Binding<Any?>) -> some View {
        if let favorite = favorite{
            StarButton(isStared: favorite.contains(object: self), action: { [self] in
                withAnimation{
                    isElement(of: favorite) ? removeFromKollections(favorite) : addToKollections(favorite)
                }
            })
        }
        
        PinnedButton(isPinned: pinned.wrappedValue as? Sofha == self, action: { [self] in
            withAnimation{
                pinned.wrappedValue = (pinned.wrappedValue as? Sofha == self) ? nil : self
            }
        })

    }

}

extension View {
    @ViewBuilder
    func previewMenu<Menu: View>(
        @ViewBuilder menu: @escaping () -> Menu
    ) -> some View {
        self
        .contextMenu(menuItems: {
            menu()
        }, preview: {
            self
        })
    }
}
