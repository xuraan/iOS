//
//  SafeArea.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-29.
//

import SwiftUI

struct SafeAreaKey: EnvironmentKey {
    static var defaultValue = EdgeInsets()
}

extension EnvironmentValues {
    var safeArea: EdgeInsets {
        get{self[SafeAreaKey.self]}
        set{self[SafeAreaKey.self] = newValue}
    }
}
