//
//  SuraPages.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SuraPages: View {
    @Binding var selection: Int
    @EnvironmentObject var kModel: KollectionProvider
    @EnvironmentObject var qModel: QuranViewModel
    @EnvironmentObject var model: Model
    
    
    init(selection: Binding<Int>) {
        self._selection = selection
    }
    
    var body: some View {
        PageViewController(pages: ([Sura.all.last!] + Sura.all + [Sura.all.first!]).map{
            SuraView(for: $0)
                .environmentObject(qModel)
                .environmentObject(kModel)
                .environmentObject(model)
        }, currentPage: $selection, isReversed: true)
        .environment(\.layoutDirection, .leftToRight)
    }
    
}

struct SuraPages_Previews: PreviewProvider {
    static var previews: some View {
        SuraPages(selection: .constant(1))
    }
}
