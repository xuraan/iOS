//
//  NSOrderedSet.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension NSOrderedSet {
    var ayas: [Aya]{ self.array as? [Aya] ?? [] }
    var suras: [Sura]{ self.array as? [Sura] ?? []}
    var sofhas: [Sofha]{ self.array as? [Sofha] ?? [] }
}
