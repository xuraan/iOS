//
//  Sofha.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

extension Sofha {
    func isElement(of kollection: Kollection?) -> Bool {
        if let kollection = kollection {
            return self.kollections.contains(kollection)
        }
        return false
    }

    var surasNames: [String] {
        suras.suras.map{ $0.name  }
    }
    var surasFullNames: [String] {
        suras.suras.map{ "\($0.translation) - \($0.phonetic) - \($0.name)" }
    }
}
