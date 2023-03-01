//
//  QuranIndeView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct QuranIndeView: View {
    @State var tab: Tab = .sura
    var body: some View {
        Group{
            switch tab {
            case .sura: SuraList()
            case .sofha: SofhaList()
            case .hizb: HizbList()
            }
        }
        .navigationTitle("Index")
        .toolbar {
            ToolbarItem(placement: .status) {
                Picker("", selection: $tab) {
                    ForEach(Tab.allCases){ tab in
                        Text(LocalizedStringKey(tab.rawValue))
                            .tag(tab)
                    }
                }.pickerStyle(.segmented)
            }
        }
    }
    
    enum Tab: String, CaseIterable, Identifiable {
        case hizb, sura, sofha
        var id: Self{self}
    }
}

struct QuranIndeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            QuranIndeView()
        }
    }
}
