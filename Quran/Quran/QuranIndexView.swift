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
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var suras: FetchedResults<Sura>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)]
    ) var sofhas: FetchedResults<Sofha>
    var body: some View {
        GeometryReader{ proxy in
            TabView(selection: $selection){
                NavigationStack{
                    SuraList(suras: Array(suras))
                    .toolbar{
                        ToolbarItem(placement: .confirmationAction){
                            CloseButton()
                        }
                    }
                    .navigationTitle("Index")
                }
                .tag(1)
                NavigationStack{
                    SofhaList(sofhas: Array(sofhas))
                        .toolbar{
                            ToolbarItem(placement: .primaryAction){
                                CloseButton()
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
