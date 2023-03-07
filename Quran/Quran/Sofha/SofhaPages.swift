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
        PageViewController(pages: ( [Sofha.all.last!]+Sofha.all+[Sofha.all.first!]).map{
            SofhaView(isExtended: $isExtended, for: $0)
        }, currentPage: $selection, isReversed: true)
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
        .environment(\.layoutDirection, .leftToRight)
    }
}
