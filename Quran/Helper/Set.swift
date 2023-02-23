//
//  Set.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

extension Set {
    mutating func toggle<T: Hashable>(_ member: T) {
        if let element = member as? Element {
            if self.contains(element) {
                self.remove(element)
            } else {
                self.insert(element)
            }
        }
    }
}
