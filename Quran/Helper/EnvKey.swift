//
//  EnvKey.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

//MARK: - Forvoritekey
struct FavoriteKey: EnvironmentKey {
    static var defaultValue: Kollection?
}
extension EnvironmentValues {
    var favorite: Kollection? {
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
    static var defaultValue: Binding<Any?> = .constant(nil)
}
extension EnvironmentValues {
    var pinned: Binding<Any?> {
        get{self[PinnedKey.self]}
        set{
            store()
            self[PinnedKey.self] = newValue
            func store(){
                if let sura = newValue.wrappedValue as? Sura {
                    UserDefaults.standard.set("pinnedSura#\(sura.id)", forKey: "pinned")
                } else if let aya = newValue.wrappedValue as? Aya {
                    UserDefaults.standard.set("pinnedAya#\(aya.id)", forKey: "pinned")
                } else if let sofha = newValue.wrappedValue as? Sofha{
                    UserDefaults.standard.set("pinnedSofha#\(sofha.id)", forKey: "pinned")
                }
            }
        }
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

struct OnCoverViewHiddenEnvKey: EnvironmentKey {
    static let defaultValue: ()->Void = {}
}
extension EnvironmentValues {
    var onCoverViewHidden: ()->Void {
        get { self[OnCoverViewHiddenEnvKey.self] }
        set { self[OnCoverViewHiddenEnvKey.self] = newValue }
    }
}
