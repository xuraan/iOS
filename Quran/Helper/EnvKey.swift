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

//MARK: - IsDestructiveKey
struct IsDestructivePinnedKey: EnvironmentKey {
    static var defaultValue: Bool = false
}
extension EnvironmentValues {
    var isPennedDestructive: Bool {
        get{self[IsDestructivePinnedKey.self]}
        set{self[IsDestructivePinnedKey.self] = newValue }
    }
}

//MARK: - pinnedKey
struct PinnedKey: EnvironmentKey {
    static var defaultValue: Kollection = Kollection()
}
extension EnvironmentValues {
    var pinned: Kollection {
        get{self[PinnedKey.self]}
        set{self[PinnedKey.self] = newValue}
    }
}

//MARK: - For Container
struct HideOverEnvKey: EnvironmentKey {
    static let defaultValue: ()->Void = {}
}
extension EnvironmentValues {
    var hideCoverView: ()->Void {
        get { self[HideOverEnvKey.self] }
        set { self[HideOverEnvKey.self] = newValue }
    }
}

struct ShowCoverEnvKey: EnvironmentKey {
    static let defaultValue: ()->Void = {}
}
extension EnvironmentValues {
    var showCoverView: ()->Void {
        get { self[ShowCoverEnvKey.self] }
        set { self[ShowCoverEnvKey.self] = newValue }
    }
}
