//
//  SuraPages.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SuraPages: View {
    @Binding var selection: Int
    
    init(selection: Binding<Int>) {
        self._selection = selection
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Group{
                SuraView(for: Sura.all.first!)
                    .tag(115)
                
                ForEach(Sura.all.reversed()){ sura in
                        SuraView(for: sura)
                            .tag(sura.id)
                    }
                
                    SuraView(for: Sura.all.last!)
                        .tag(0)            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay{
                GeometryReader{ proxy in
                    let minX = proxy.frame(in: .global).minX
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self){ value in
//                                    self.offsetX = value
                            if selection == 0 && value == 0 {
                                selection = 114
                            }

                            if selection == 115 && value == 0 {
                                selection = 1
                            }
                        }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea(.container, edges: [.vertical])
//        .animation(.easeInOut, value: selection)
    }
    
}

struct SuraPages_Previews: PreviewProvider {
    static var previews: some View {
        SuraPages(selection: .constant(1))
    }
}
