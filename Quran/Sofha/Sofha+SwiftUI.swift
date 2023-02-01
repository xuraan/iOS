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
    var iconColor: Color { self.isFavorite ? .yellow : Color("BGI")}
}

extension View {
    @ViewBuilder
    func sofhaContextMenuWithPreview(sofha: Sofha) -> some View {
        self
        .contextMenu(menuItems: {
            if sofha.isFavorite {
                UnstarButton(action: {
                    withAnimation{
                        sofha.isFavorite = false
                    }
                })
            } else {
                StarButton{
                    withAnimation{
                        sofha.isFavorite = true
                    }
                }
            }

        }, preview: {
            self
        })
    }
}
