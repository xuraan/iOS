//
//  EnvKey.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

//MARK: - Forvoritekey
struct FavoriteKey: EnvironmentKey {
    static var defaultValue: Kollection = Kollection()
}
extension EnvironmentValues {
    var favorite: Kollection {
        get{self[FavoriteKey.self]}
        set{self[FavoriteKey.self] = newValue}
    }
}

//MARK: - IsDestructiveKey
struct IsDestructiveKey: EnvironmentKey {
    static var defaultValue: Bool = false
}
extension EnvironmentValues {
    var isDestructive: Bool {
        get{self[IsDestructiveKey.self]}
        set{self[IsDestructiveKey.self] = newValue }
    }
}
