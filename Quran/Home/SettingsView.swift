//
//  SettingsView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List{
            QuranSettings()
            AyaSettings()
            ModelSettings()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AyaViewModel())
            .environmentObject(QuranViewModel())
            .environmentObject(Model())
    }
}
