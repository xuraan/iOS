//
//  FavoriteView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.favorite) var favorite

    var body: some View {
        NavigationStack{
            List{
                KollectionItemsSection(for: favorite)
            }
            .navigationTitle("Favorites")
        }
        .environment(\.favorite, favorite)
        .environment(\.isDestructive, true)
    }
}

