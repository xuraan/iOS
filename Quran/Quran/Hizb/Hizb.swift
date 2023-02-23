//
//  Hizb.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-17.
//

import SwiftUI

struct Hizb: Codable, Hashable, Identifiable {
    let id: Int
}

//MARK: - Proprieties
extension Hizb {
    var ayas: [Aya] { QuranProvider.shared.ayasByHizb[id] ?? [] }
}

extension Hizb {
    static let all: [Hizb] = QuranProvider.shared.hizbs
}
