//
//  QuranSettings.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-22.
//

import SwiftUI

struct QuranSettings: View {
    @EnvironmentObject var qModel: QuranViewModel
    @State var arabicFontSize: Double = 0
    @State var transFontSize: Double = 0
    
    var body: some View {
        
        HStack{
            Text("Display").font(.footnote).textCase(.uppercase)
            Spacer()
            Picker("", selection: $qModel.tab) {
                ForEach(QuranViewModel.Tab.allCases){ tab in
                    Text(tab.rawValue.capitalized)
                        .tag(tab)
                }
            }
            .pickerStyle(.segmented)
        }
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        
        Section{
            Slider(value: $arabicFontSize, in: 20...50, label: {
                
            }, minimumValueLabel: {
                Image(systemName: "character.cursor.ibeam")
                    .font(.caption)
                    .onTapGesture {
                        withAnimation{
                            arabicFontSize = 20
                        }
                    }
            }, maximumValueLabel: {
                Image(systemName: "character.cursor.ibeam")
                    .font(.title3)
                    .onTapGesture {
                        withAnimation{
                            arabicFontSize = 50
                        }
                    }
            })
            NavigationLink {
                FontPickerLink(selection: $qModel.arabicFont)
            } label: {
                HStack{
                    Text("Font")
                        .badge(qModel.arabicFont.name)
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                .foregroundColor(.primary)
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
        Section{
            Toggle("Enable", isOn: $qModel.isTransEnable)
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
            Toggle("Bold text", isOn: $qModel.isTransBold)
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
        .onAppear{
            withAnimation{
                arabicFontSize = qModel.arabicFontSize
                transFontSize = qModel.transFontSize
            }
        }
        .onDisappear{
            withAnimation{
                qModel.arabicFontSize = arabicFontSize
                qModel.transFontSize = transFontSize
            }
        }
    }
    
    func setDefaultAyaArabicSettings(){
        self.arabicFontSize = 30.0
        ///More things to add here in soon
    }
    
    func setDefaultAyaTransSettings(){
        qModel.isTransEnable = true
        qModel.isTransBold = false
        self.transFontSize = 17.0
        ///More things to add here in soon
    }
}

struct FontPickerLink: View {
    @Binding var selection: CustomFont
    @Environment(\.dismiss) var dismiss
    init(selection: Binding<CustomFont>){
        self._selection = selection
    }
    var body: some View {
        List{
            Section{
                ForEach(CustomFont.availableForAyaArabicText){ font in
                    Button{
                        withAnimation{
                            selection = font
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                dismiss()
                            })
                        }
                    } label: {
                        Label(title: {
                            Text(font.name).foregroundColor(.primary)
                        }, icon: {
                            Image(systemName: "checkmark")
                                .opacity(selection == font ? 1 : 0)
                        })
                    }
                }
            }
            selection.detail
        }
        .navigationTitle("Font")
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
