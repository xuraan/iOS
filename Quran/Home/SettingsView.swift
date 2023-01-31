//
//  SettingsView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct SettingsView: View {
    @Binding var stack: NavigationPath
    init(stack: Binding<NavigationPath>) {
        self._stack = stack
    }
    var body: some View {
        List{
            QuranSettings()
            AyaSettings(stack: $stack)
            ModelSettings()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(stack: .constant(NavigationPath()))
            .environmentObject(AyaViewModel())
            .environmentObject(QuranViewModel())
            .environmentObject(Model())
    }
}
