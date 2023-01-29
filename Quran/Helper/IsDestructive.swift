//
//  IsDestructive.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct IsDestructiveKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var isDestructive: Bool {
        get{self[IsDestructiveKey.self]}
        set{self[IsDestructiveKey.self] = newValue }
    }
}
