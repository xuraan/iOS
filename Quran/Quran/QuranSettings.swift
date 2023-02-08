//
//  QuranSettings.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

struct QuranSettings: View {
    @EnvironmentObject var quranVM: QuranViewModel
    var body: some View {
        HStack{
            Text("Quran dispaly mode")
                .font(.subheadline.smallCaps())
                .foregroundColor(.secondary)
            Spacer()
            Picker(selection: $quranVM.mode, label: Text("Picker")) {
                ForEach(QuranViewModel.Mode.allCases){ mode in
                    Text(mode.rawValue)
                        .tag(mode)
                }
            }
            .pickerStyle(.segmented)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(Color.clear)
    }
}

struct QuranSettings_Previews: PreviewProvider {
    static var previews: some View {
        List{
            QuranSettings()
        }
        .environmentObject(QuranViewModel())
    }
}
