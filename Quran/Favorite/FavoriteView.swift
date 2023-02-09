//
//  FavoriteView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-08.
//

import SwiftUI

struct FavoriteView: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: ("isFavorite == true"))
    ) var suras: FetchedResults<Sura>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: ("isFavorite == true"))
    ) var ayas: FetchedResults<Aya>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: ("isFavorite == true"))
    ) var sofhas: FetchedResults<Sofha>
    var body: some View {
        List{
            if !ayas.isEmpty {
                Section("ayas"){
                    ForEach(ayas){aya in
                        AyaRow(for: aya)
                    }
                }
            }
            if !sofhas.isEmpty {
                Section("sofhas"){
                    ForEach(sofhas){sofha in
                        SofhaRow(for: sofha)
                    }
                }
            }
            if !suras.isEmpty {
                Section("suras"){
                    ForEach(suras){sura in
                        SuraRow(for: sura)
                    }
                }
            }
        }
        .environment(\.isDestructive, true)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
