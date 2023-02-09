//
//  FavoriteView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-08.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favorite: Kollection
    var body: some View {
        List{
            if !favorite.ayas.ayas.isEmpty {
                Section("ayas"){
                    ForEach(favorite.ayas.ayas){aya in
                        AyaRow(for: aya)
                    }
                }
            }
            if !favorite.sofhas.sofhas.isEmpty {
                Section("sofhas"){
                    ForEach(favorite.sofhas.sofhas){sofha in
                        SofhaRow(for: sofha)
                    }
                }
            }
            if !favorite.suras.suras.isEmpty {
                Section("suras"){
                    ForEach(favorite.suras.suras){sura in
                        SuraRow(for: sura)
                    }
                }
            }
        }
        .environment(\.isDestructive, true)
    }
}
