//
//  ModelSettings.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

struct ModelSettings: View {
    @EnvironmentObject var model: Model
    var body: some View {
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
