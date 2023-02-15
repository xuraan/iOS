//
//  NSSet.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension NSSet {
    var ayas: [Aya]{
        let ayas = self.allObjects as? [Aya] ?? []
        return ayas.sorted{$0.id < $1.id}
    }
    var suras: [Sura]{
        let suras = self.allObjects as? [Sura] ?? []
        return suras.sorted{$0.id < $1.id}
    }
    var sofhas: [Sofha]{
        let sofhas = self.allObjects as? [Sofha] ?? []
        return sofhas.sorted{ $0.id < $1.id }
    }
}
