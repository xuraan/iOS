//
//  Model.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

class Model: ObservableObject {
    @Published var preferredColorScheme: ColorScheme?
    @Published var langage: Local = .fr

    

    enum Local: String, Identifiable, CaseIterable, Hashable {
        case fr = "fr_FR"
        case ar = "ar_AR"
        case en = "en_US"
        case bm = "bm_ML"
        var id: Self{self}
        
        var code: String {
            switch self {
            case .bm:
                return "bm"
            case .fr:
                return "fr"
            case .en:
                return "en"
            case .ar:
                return "ar"
            }
        }
        
        var icon: String {
            switch self {
            case .bm:
                return "🇲🇱"
            case .fr:
                return "🇫🇷"
            case .en:
                return "🏴󠁧󠁢󠁥󠁮󠁧󠁿"
            case .ar:
                return "🇦🇪"
            }
        }
        
        var name: String {
            switch self {
            case .bm:
                return "Bambara"
            case .fr:
                return "French"
            case .en:
                return "English"
            case .ar:
                return "Arabic"
            }
        }
        
        var isBeta: Bool {
            Self.betas.contains(self)
        }
        
        static var betas: [Self] = [.bm]
        
        static var valids: [Self] = allCases.filter{!betas.contains($0)}
        
        static func get(identifier: String) -> Self? {
            return allCases.first(where: { $0.rawValue == identifier })
        }
        static func get(code: String) -> Self? {
            return allCases.first(where: { $0.code == code })
        }
    }
    
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



