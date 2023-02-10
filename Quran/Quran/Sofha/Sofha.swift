//
//  Sofha.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

extension Sofha {
    func isElement(of kollection: Kollection) -> Bool {
        return self.kollections.contains(kollection)
    }
    var surasNames: [String] {
        suras.suras.map{ $0.name  }
    }
    var surasFullNames: [String] {
        suras.suras.map{ "\($0.translation) - \($0.phonetic) - \($0.name)" }
    }
}
