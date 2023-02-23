//
//  Sura.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-17.
//

import SwiftUI

struct Sura: Hashable, Identifiable {
    let id: Int
    let name: String
    let phonetic: String
    let translation: String
    let place: String
}

//MARK: - Proprieties
extension Sura {
    var ayas: [Aya] { QuranProvider.shared.ayasBySura[id] ?? [] }
    var sofhas: [Aya] { QuranProvider.shared.ayasBySura[id] ?? [] }
}

extension Sura {
    static let all: [Sura] = QuranProvider.shared.suras
}

//MARK: - Make Sura codable
extension Sura: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, phonetic
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        phonetic = try container.decode(String.self, forKey: .phonetic)
       
        self.translation = NSLocalizedString( "s\(id)", tableName: "suraNameTranslation", comment: "sura name trans")
        self.place = NSLocalizedString( QuranProvider.madaniyaSuraIDs.contains(id) ? "md" : "mk" , comment: "sura place")
    }
}

//MARK: - Conform to QuranItem
extension Sura: QuranItem {
    
}
