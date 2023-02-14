//
//  Aya.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI


extension Aya {
    var number: Int  { (self.sura.ayas.ayas.firstIndex(of: self) ?? 0) + 1 }
    var translation: String { NSLocalizedString( "a\(self.id)", tableName: "ayas", comment: "Ayas trans") }
    func isElement(of kollection: Kollection?) -> Bool {
        if let kollection = kollection {
            return self.kollections.contains(kollection)
        }
        return false
    }
}
