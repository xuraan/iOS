//
//  NSSet.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension NSSet {
    var ayas: [Aya]{ self.allObjects as? [Aya] ?? []}
    var suras: [Sura]{self.allObjects as? [Sura] ?? []}
    var sofhas: [Sofha]{ self.allObjects as? [Sofha] ?? [] }
}
