//
//  FavoriteView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    var body: some View {
        List{
            Group{
                if !favorite.ayas.isEmpty {
                    Section{
                        ForEach(favorite.ayas){ aya in
                            AyaRow(for: aya)
                                .fullSeparatoreListPlain
                        }
                    } header: {
                        Text("Aya")
                    }
                }
                if !favorite.hizbs.isEmpty {
                    Section{
                        ForEach(favorite.hizbs){ hizb in
                            HizbRow(for: hizb)
                                .fullSeparatoreListPlain
                        }
                    } header: {
                        Text("Hizb")
                    }
                }
                if !favorite.sofhas.isEmpty {
                    Section{
                        ForEach(favorite.sofhas){ sofha in
                            SofhaRow(for: sofha)
                                .fullSeparatoreListPlain
                        }
                    } header: {
                        Text("Sofha")
                    }
                }
                if !favorite.suras.isEmpty {
                    Section{
                        ForEach(favorite.suras){ sura in
                            SuraRow(for: sura)
                                .fullSeparatoreListPlain
                        }
                    } header: {
                        Text("Sura")
                    }
                }            }
            .environment(\.isDestructiveStarButton, true)
        }
        .navigationTitle("Favorites")
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            FavoriteView()
        }
    }
}
