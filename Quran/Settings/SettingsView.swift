//
//  SettingsView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct SettingsView: View {
    @State var stack: NavigationPath = .init()
    @EnvironmentObject var model: Model
    @EnvironmentObject var ayaVM: AyaViewModel
    @EnvironmentObject var searchVM: SearchModel
    @EnvironmentObject var quranVM: QuranViewModel
    var body: some View {
        NavigationStack(path: $stack){
            List{
                QuranSettings()
                AyaSettings(stack: $stack)
                ModelSettings()
            }
            .padding(.top, -30)
            .toolbar{
                CloseButton()
            }
            .navigationTitle("Settings")
            .navigationDestination(for: String.self){ value in
                if value == "ayaFontNames" {
                    List{
                        Section{
                            ForEach(CustomFont.availableForAyaArabicText){ font in
                                Button{
                                    withAnimation{
                                        ayaVM.arabicFont = font
                                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                            stack.removeLast()
                                        })
                                    }
                                } label: {
                                    Label(title: {
                                        Text(font.name).foregroundColor(.primary)
                                    }, icon: {
                                        Image(systemName: "checkmark").opacity(ayaVM.arabicFont == font ? 1 : 0)
                                    })
                                }
                            }
                        }
                        ayaVM.arabicFont.detail
                    }
                    .navigationTitle("Font")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
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
