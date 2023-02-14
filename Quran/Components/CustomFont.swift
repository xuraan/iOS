//
//  CustomFont.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-14.
//

import SwiftUI

enum CustomFont: String, Identifiable, CaseIterable, Hashable {
    case mequran = "me_quran"
    case amiri = "AmiriQuran-Regular"
    case waseem = "Waseem"
    var id: Self{self}
    
    var name: String {
        switch self {
        case .mequran:
            return "me quran"
        case .amiri:
            return "amiri"
        case .waseem:
            return "waseem"
        }
    }
    
    var detail: some View {
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
            case .mequran:
                 VStack {
                    Text("""
                    The me_quran font is a rich Arabic font specially designed for rendering Quran texts like Medina Mushaf.
                    
                    License: me_quran is open source.

                    """)
                }
            case .waseem:
                VStack{
                    Text("detail coming soon")
                }
            }
        }
        .font(.footnote)
        .foregroundColor(.secondary)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(Color.clear)
    }
    
    func size(_ size: Double) -> Font {
        Font.custom(self.rawValue, size: size)
    }
    
    public static func mequran(_ size: Double) -> Font {
        Font.custom( "me_quran" , size: size)
    }
    
    public static func waseem(_ size: Double, weight: Font.Weight = .regular) -> Font {
        Font.custom( "Waseem" , size: size).weight(weight)
    }
    
    static var availableForAyaArabicText: [CustomFont] {
        [.amiri, .mequran]
    }
}
