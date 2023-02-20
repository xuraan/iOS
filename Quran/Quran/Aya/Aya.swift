//
//  Aya.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-17.
//

import SwiftUI

struct Aya: Hashable, Identifiable  {
    let id: Int
    let number: Int
    let text: String
    let simple: String
    let suraID: Int
    let sofhaID: Int
    let hizbID: Int
    let translation: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        number = try container.decode(Int.self, forKey: .number)
        text = try container.decode(String.self, forKey: .text)
        simple = try container.decode(String.self, forKey: .simple)
        suraID = try container.decode(Int.self, forKey: .suraID)
        sofhaID = try container.decode(Int.self, forKey: .sofhaID)
        hizbID = try container.decode(Int.self, forKey: .hizbID)
        self.translation = NSLocalizedString( "a\(id)", tableName: "ayasTranslation", comment: "Ayas trans")
    }

}

//MARK: - Make Aya computed properties
extension Aya {
    var sura: Sura { QuranProvider.shared.suras[suraID-1] }
    var hizb: Hizb { QuranProvider.shared.hizbs[hizbID-1] }
    var sofha: Sofha { QuranProvider.shared.sofhas[sofhaID-1] }
}

//MARK: - Helper
extension Aya {
    var secondaryID: String {"\(sura.id):\(number)"}
    var textWithEndAya: String {self.text + "\u{FD3F}"+"\(self.number)".toArabicNumeral+"\u{FD3E}"}
}

//MARK: - Make Aya codable
extension Aya: Codable {
    enum CodingKeys: String, CodingKey {
        case id, number, text, simple, suraID, sofhaID, hizbID
    }
}
