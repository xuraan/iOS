//
//  QuranIndexView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct QuranIndexView: View {
    @State var selection = 1
    @EnvironmentObject var quranMV: QuranViewModel
    @Binding var selectedDetent: PresentationDetent
    var suras: [Sura]
    var sofhas: [Sofha]
    init(suras: [Sura], sofhas: [Sofha], selectedDetent: Binding<PresentationDetent>) {
        self.suras = suras
        self.sofhas = sofhas
        self._selectedDetent = selectedDetent
    }
    var body: some View {
        GeometryReader{ proxy in
            TabView(selection: $selection){
                NavigationStack{
                    SuraList(suras: suras)
                    .toolbar{
                        ToolbarItem(placement: .destructiveAction){
                            CloseButton(action: {
                                withAnimation{
                                    if quranMV.isShow{
                                        quranMV.isShowIndex = false
                                    } else {
                                        selectedDetent = .height(12+proxy.safeAreaInsets.bottom)
                                    }
                                }
                            })
                        }
                        
                    }
                    .navigationTitle("Index")
                }
                .tag(1)
                
                NavigationStack{
                    SofhaList(sofhas: sofhas)
                    .toolbar{
                        ToolbarItem(placement: .destructiveAction){
                            CloseButton(action: {
                                withAnimation{
                                    if quranMV.isShow{
                                        quranMV.isShowIndex = false
                                    } else {
                                        selectedDetent = .height(12+proxy.safeAreaInsets.bottom)
                                    }
                                }
                            })
                        }
                        
                    }
                    .navigationTitle("Index")
                }
                .tag(2)

            }
            
            .overlay(alignment: .bottom){ 
                Picker(selection: $selection, label: Text("Picker")) {
                    Text("sura").tag(1)
                    Text("sofha").tag(2)
               }
               .pickerStyle(.segmented)
               .frame(width: 200)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
