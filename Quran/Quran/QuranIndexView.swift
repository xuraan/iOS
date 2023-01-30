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
    var suras: [Sura]
    var sofhas: [Sofha]
    init(suras: [Sura], sofhas: [Sofha]) {
        self.suras = suras
        self.sofhas = sofhas
    }
    var body: some View {
        GeometryReader{ proxy in
            TabView(selection: $selection){
                NavigationStack{
                    SuraList(suras: suras, hidePinnedView: !quranMV.selectedDetent.isLarge)
                    .toolbar{
                        ToolbarItem(placement: .principal, content: {
                            Text("Index")
                                .frame(width: proxy.size.width, height: 25+proxy.safeAreaInsets.bottom, alignment: .center)
                                .background(.red.opacity(0.0001))
                                .font(quranMV.selectedDetent != .large ? .title3 : .headline)
                                .fontWeight(.semibold)
                                .contentTransition(.interpolate)
                                .onTapGesture {
                                    if !quranMV.selectedDetent.isLarge {
                                        quranMV.selectedDetent = .large
                                    }
                                }
                                .offset(x: 26)
                                .animation(.easeInOut, value: quranMV.selectedDetent)
                                
                        })
                        ToolbarItem(placement: .confirmationAction){
                            CloseButton(action: {
                                withAnimation{
                                    if quranMV.isShow{
                                        quranMV.selectedDetent = .hide
                                    } else {
                                        quranMV.selectedDetent = .float
                                    }
                                    
                                }
                            }).opacity(quranMV.selectedDetent.isLarge ? 1 : 0)
                        }
                        
                    }
                    .toolbar(!quranMV.selectedDetent.isLarge ? .hidden : .visible, for: .tabBar)
                }
                .tag(1)
                
                NavigationStack{
                    SofhaList(sofhas: sofhas)
                        .toolbar{
                            ToolbarItem(placement: .principal, content: {
                                Text("Index")
                                    .frame(width: proxy.size.width, alignment: .center)
                                    .background(.red.opacity(0.00001))
                                    .font(quranMV.selectedDetent != .large ? .title3 : .headline)
                                    .fontWeight(.semibold)
                                    .contentTransition(.interpolate)
                                    .onTapGesture {
                                        if !quranMV.selectedDetent.isLarge {
                                            quranMV.selectedDetent = .large
                                        }
                                    }
                                    .offset(x: 26)
                                    .animation(.easeInOut, value: quranMV.selectedDetent)
                                    
                            })
                            ToolbarItem(placement: .confirmationAction){
                                CloseButton(action: {
                                    withAnimation{
                                        if quranMV.isShow{
                                            quranMV.selectedDetent = .hide
                                        } else {
                                            quranMV.selectedDetent = .float
                                        }
                                        
                                    }
                                }).opacity(quranMV.selectedDetent.isLarge ? 1 : 0)
                            }
                            
                        }
                        .toolbar(!quranMV.selectedDetent.isLarge ? .hidden : .visible, for: .tabBar)
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
               .opacity(!quranMV.selectedDetent.isLarge ? 0 : 1)
            }
        }
        .ignoresSafeArea(.keyboard)

    }
}
