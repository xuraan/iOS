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
            Button(action:{
                stack.append("ayaFontNames")
            }){
                HStack{
                    Text("Font")
                        .badge(ayaVM.ayaFontName)
                    Image(systemName: "chevron.forward").foregroundColor(.gray)
                }
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
        Section{
            Toggle("Enable", isOn: $isTransEnable)
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
            })
            Toggle("Bold text", isOn: $isTransBold)
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
