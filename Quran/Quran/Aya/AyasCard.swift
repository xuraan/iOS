//
//  AyasCard.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct AyasCard: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.showCoverView) var showCoverView
    @EnvironmentObject var qModel: QuranViewModel
    
    var header: AnyView
    var footer: AnyView
    let ayas: [Aya]
    
    init<Header: View>(_ ayas: [Aya], @ViewBuilder header: @escaping ()-> Header) {
        self.header = AnyView(header())
        footer = AnyView(EmptyView())
        self.ayas = ayas
    }
    
    init<Footer: View>(ayas: [Aya], @ViewBuilder footer: @escaping ()-> Footer) {
        self.footer = AnyView(footer())
        header = AnyView(EmptyView())
        self.ayas = ayas
    }
    
    init<Header: View, Footer: View>(
        _ ayas: [Aya],
        @ViewBuilder header: @escaping ()-> Header,
        @ViewBuilder footer: @escaping ()-> Footer
    ) {
        self.footer = AnyView(footer())
        self.header = AnyView(header())
        self.ayas = ayas
    }
    
    var body: some View {
        
        Button {
            dismiss()
            showCoverView()
            qModel.openButtonAction(ayas.first!)
        } label: {
            VStack{
                header
                    .lineLimit(1)
                    .font(.footnote.bold())
                    .foregroundColor(.secondary)

                Text(ayas.map{ $0.textWithEndAya }.joined(separator: " "))
                    .environment(\.layoutDirection, .rightToLeft)
                    .font(CustomFont.mequran(22))
                    .lineLimit(3)
                    .foregroundColor(.primary)
                
                Text(ayas.map{ $0.translation }.joined(separator: " "))
                    .environment(\.layoutDirection, .leftToRight)
                    .foregroundColor(.secondary)
                    .italic()
                    .lineLimit(3)
                
                footer
                    .lineLimit(1)
                    .font(.footnote.bold())
                    .foregroundColor(.secondary)
                    .offset(y: 10)
            }
            .environment(\.colorScheme, .dark)
        }

        .padding()
        .listRowInsets(EdgeInsets())
//        .listRowBackground(Color.accentColor)
        .background(Color.accentColor)
    }
}

