//
//  Model.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

class Model: ObservableObject {
    @Published var preferredColorScheme: ColorScheme? {
        didSet {
            UserDefaults.standard.set(preferredColorScheme?.hashValue ?? 0, forKey: "preferredColorScheme")
        }
    }
    
    @Published var text: String = ""
    
    init(){
        preferredColorScheme = ColorScheme.allCases.first{ $0.hashValue == UserDefaults.standard.integer(forKey: "preferredColorScheme") }
    }
    
}


struct ModelSettings: View {
    @EnvironmentObject var model: Model
    @Environment(\.locale) var local
    var body: some View {
        Section{
            Button{
                let appSettings = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(appSettings)
            } label: {
                HStack{
                    Label(title: {
                        Text("Language").foregroundColor(.primary)
                    }, icon: {
                        Image(systemName: "globe")
                    })
                    .badge(Locale.current.localizedString(forIdentifier: Locale.current.identifier)?.prefix(20))
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                .foregroundColor(.primary)
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
