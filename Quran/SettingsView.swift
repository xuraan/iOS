//
//  SettingsView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List{
                QuranSettings()
                ModelSettings()
            }
            .toolbar(content: {
               CloseButton()
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(QuranViewModel())
            .environmentObject(Model())
    }
}
