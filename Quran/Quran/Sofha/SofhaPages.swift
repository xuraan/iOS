//
//  SofhaPages.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SofhaPages: View {
    @Binding var selection: Int
    @Binding var hideToolbar: Bool
    @State var isExtended: Bool = false
    init(selection: Binding<Int>, hideToolbar: Binding<Bool> = .constant(false)) {
        self._selection = selection
        self._hideToolbar = hideToolbar
    }
    var body: some View {
        
        TabView(selection: $selection) {
            Group{
                SofhaView(isExtended: $isExtended,for: Sofha.all.first!)
                    .tag(605)
                
                ForEach(Sofha.all.reversed()){ sofha in
                    SofhaView(isExtended: $isExtended, for: sofha)
                            .tag(sofha.id)
                    }
                
                    SofhaView(isExtended: $isExtended, for: Sofha.all.last!)
                        .tag(0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay{
                GeometryReader{ proxy in
                    let minX = proxy.frame(in: .global).minX
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self){ value in
//                                    self.offsetX = value
                            if selection == 0 && value == 0 {
                                selection = 604
                            }

                            if selection == 605 && value == 0 {
                                selection = 1
                            }
                        }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onChange(of: isExtended) { value in
            withAnimation{
                hideToolbar = value
            }
        }
        .overlay(alignment: .bottom) {
            Picker("", selection: $selection) {
                ForEach(1..<605){ i in
                    Text("\(i)")
                        .tag(i)
                }
            }
            .menuIndicator(.hidden)
            .opacity(hideToolbar ? 0 : 1)
        }
    }
}

struct SofhaPages_Previews: PreviewProvider {
    static var previews: some View {
        SofhaPages(selection: .constant(1))
    }
}
