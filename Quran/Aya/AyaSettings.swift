//
//  AyaSettings.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct AyaSettings: View {
    @EnvironmentObject var ayaVM: AyaViewModel
    @EnvironmentObject var quranVM: QuranViewModel
    @State var ayaFontSize: Double = 0
    @State var transFontSize: Double = 0
    @State var isTransEnable: Bool = false
    @State var isTransBold: Bool = false
    @Binding var stack: NavigationPath
    init(stack: Binding<NavigationPath>) {
        self._stack = stack
    }
    var body: some View {
        Section{
            ListRow{
                Slider(value: $ayaFontSize, in: 20...50, label: {
                    
                }, minimumValueLabel: {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.caption)
                        .onTapGesture {
                            withAnimation{
                                ayaFontSize = 20
                            }
                        }
                }, maximumValueLabel: {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.title3)
                        .onTapGesture {
                            withAnimation{
                                ayaFontSize = 50
                            }
                        }
                })
            }
            ListRow{
                NavigationLink(destination: {
                    List{
                        Section{
                            ForEach(AyaViewModel.ayaFonts, id: \.self){ name in
                                Button{
                                    withAnimation{
                                        ayaVM.ayaFontName = name
                                    }
                                } label: {
                                    Label(title: {
                                        Text(name).foregroundColor(.primary)
                                    }, icon: {
                                        Image(systemName: "checkmark").opacity(ayaVM.ayaFontName == name ? 1 : 0)
                                    })
                                }
                            }
                        } footer: {
                            if ayaVM.ayaFontName == "me_quran" {
                                Text("Font detail me_quran")
                            } else {
                                Text("Font detail amiri")
                            }
                        }
                    }
                }, label: {
                    HStack{
                        Text("Font")
                            .badge(ayaVM.ayaFontName)
                    }
                })
            }
        } header: {
            HStack{
                Text("aya")
                Spacer()
                Button{
                    withAnimation{
                        setDefaultAyaArabicSettings()
                    }
                } label: {
                    Label("Default values", systemImage: "gearshape.arrow.triangle.2.circlepath")
                        .font(.caption2)
                }
            }
        }
        .onAppear{
            withAnimation{
                ayaFontSize = ayaVM.ayaFontSize
                transFontSize = ayaVM.transFontSize
                isTransEnable = ayaVM.isTransEnable
                isTransBold = ayaVM.isTransBold
            }
        }
        .onDisappear{
            withAnimation{
                ayaVM.ayaFontSize = ayaFontSize
                ayaVM.transFontSize = transFontSize
                ayaVM.isTransEnable = isTransEnable
                ayaVM.isTransBold = isTransBold
            }
        }
        Section{}
        Section{
            ListRow{
                Toggle("Enable", isOn: $isTransEnable)
            }
            ListRow{
                Slider(value: $transFontSize, in: 10...30, label: {
                    
                }, minimumValueLabel: {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.caption)
                        .onTapGesture {
                            withAnimation{
                                transFontSize = 10
                            }
                        }
                }, maximumValueLabel: {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.title3)
                        .onTapGesture {
                            withAnimation{
                                transFontSize = 30
                            }
                        }
                })            }
            ListRow{
                Toggle("Bold text", isOn: $isTransBold)
            }
        } header : {
            HStack{
                Text("Translation")
                Spacer()
                Button{
                    withAnimation{
                        setDefaultAyaTransSettings()
                    }
                } label: {
                    Label("Default values", systemImage: "gearshape.arrow.triangle.2.circlepath")
                        .font(.caption2)
                }
            }
        }
        Section{}
    }
    
    func setDefaultAyaArabicSettings(){
        self.ayaFontSize = 30.0
        ///More things to add here in soon
    }
    
    func setDefaultAyaTransSettings(){
        self.isTransEnable = true
        self.isTransBold = false
        self.transFontSize = 17.0
        ///More things to add here in soon
    }
}

struct AyaSettings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            List{
                AyaSettings(stack: .constant(NavigationPath()))
            }
            .scrollContentBackground(.hidden)
            .environmentObject(AyaViewModel())
            .environmentObject(QuranViewModel())
        }
    }
}
