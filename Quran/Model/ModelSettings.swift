//
//  ModelSettings.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

struct ModelSettings: View {
    @EnvironmentObject var model: Model
    @Environment(\.locale) var local
    var body: some View {
        Section{
            Button{
                let appSettings = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(appSettings)
            } label: {
                Label(title: {
                    Text("Language").foregroundColor(.primary)
                }, icon: {
                    Image(systemName: "globe")
                })
                .badge(
                    Locale.current.localizedString(forIdentifier: Locale.current.identifier)
                    )
            }
        }
        Section("colorscheme"){
            Picker("", selection: $model.preferredColorScheme, content: {
                Text("Dark").tag(ColorScheme.dark as ColorScheme?)
                Text("System").tag(nil as ColorScheme?)
                Text("Light").tag(ColorScheme.light as ColorScheme?)
            })
            .pickerStyle(.segmented)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
        }
    }
}

struct ModelSettings_Previews: PreviewProvider {
    static var previews: some View {
        List{
            ModelSettings()
                .environmentObject(Model())
        }
    }
}
