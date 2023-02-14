//
//  Model.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

class Model: ObservableObject {
    
    //MARK: - Kollection
    @Published var Kollection: Kollection?
    @Published var showAddCollection: Bool = false
    
    //MARK: - global
    @Published var preferredColorScheme: ColorScheme?
    
    //MARK: - Font
    @Published var ayaArabicFont: CustomFont = .me_quran
}


enum CustomFont: String, Identifiable, CaseIterable, Hashable {
    case me_quran = "me_quran"
    case amiri = "AmiriQuran-Regular"
    var id: Self{self}
    
    var text: some View {
        Group{
            switch self {
            case .amiri:
                 VStack {
                    Text("""
                    Designed by [Khaled Hosny](https://github.com/khaledhosny), Sebastian Kosch.

                    Amiri is a classical Arabic typeface in Naskh style for typesetting books and other running text. Its design is a revival of the beautiful typeface pioneered in early 20th century by Bulaq Press in Cairo, also known as Amiria Press, after which the font is named.
                    [More](https://amirifont.org).
                    
                    License: amiri are licensed under the [Open Font License](https://https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL).
                    """)
                }
            case .me_quran:
                 VStack {
                    Text("""
                    The me_quran font is a rich Arabic font specially designed for rendering Quran texts like Medina Mushaf.
                    
                    License: me_quran is open source.

                    """)
                }
            }
        }
        .font(.footnote)
        .foregroundColor(.secondary)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(Color.clear)
    }
}



