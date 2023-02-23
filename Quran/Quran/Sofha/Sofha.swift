//
//  Sofha.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-17.
//

import SwiftUI

struct Sofha: Codable, Hashable, Identifiable {
    let id: Int
}

//MARK: - Proprieties
extension Sofha {
    var ayas: [Aya] { QuranProvider.shared.ayasBySofha[id] ?? [] }
}

extension Sofha {
    static let all: [Sofha] = QuranProvider.shared.sofhas
}

//MARK: - Image
extension Sofha {
    var image: Image {
        Image("\(self.id)")
//        Image("test")
            .resizable()
    }
}
