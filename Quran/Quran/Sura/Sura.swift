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
}

//MARK: - Proprieties
extension Sura {
    var ayas: [Aya] { QuranProvider.shared.ayasBySura[id] ?? [] }
    var sofhas: [Aya] { QuranProvider.shared.ayasBySura[id] ?? [] }
}

//MARK: - Make Aya codable
extension Sura: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, phonetic
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        phonetic = try container.decode(String.self, forKey: .phonetic)
       
        self.translation = NSLocalizedString( "a\(id)", tableName: "suraNameLocalized", comment: "sura name trans")
    }
}
