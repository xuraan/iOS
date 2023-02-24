//
//  QuranItemsSection.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI


struct QuranItemSection<T: QuranItem>: View {
    
    var items: [T]
    var limit: Int
    var title: String
    var isDismissible: Bool
    
    init(for items: [T], title: String, limit: Int = 3, isDismissible: Bool = true) {
        self.items = items
        self.limit = limit
        self.title = title
        self.isDismissible = isDismissible
    }
    
    var body: some View {
        if !items.isEmpty {
            Section {
                ForEach( limit < 0 ? items[...] : items.prefix(limit)) { item in
                    QuranItemRow(for: item, isDismissible: isDismissible)
                        .fullSeparatoreListPlain
                }
            } header: {
                HStack{
                    Text(title)
                    Spacer()
                    if items.count > limit && limit > 0 {
                        NavigationButtomSheet{
                            QuranItemList(items: items)
                        } label: {
                            Label("More", systemImage: "link")
                                .font(.footnote)
                        }
                        .textCase(.none)
                    }
                }
            }
        }
    }
}

struct QuranItemList<T: QuranItem>: View {
    var items: [T]
    
    init(items: [T]) {
        self.items = items
    }
    
    var body: some View {
        if !items.isEmpty {
            if let suras = items as? [Sura] {
                SuraList(suras: suras)
            } else if let sofhas = items as? [Sofha] {
                SofhaList(sofhas: sofhas)
            } else if let ayas = items as? [Aya] {
                AyaList(ayas: ayas)
            } else if let hizbs = items as? [Hizb] {
                HizbList(hizbs: hizbs)
            }
        }
    }
}

