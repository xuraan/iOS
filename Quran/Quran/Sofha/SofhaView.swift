//
//  SofhaView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct SofhaView: View {
    var sofha: Sofha
    @Environment(\.colorScheme) var colorScheme
    @Binding var isExtended: Bool

    init(isExtended: Binding<Bool> = .constant(false) ,for sofha: Sofha) {
        self.sofha = sofha
        self._isExtended = isExtended
    }
    var body: some View {
        GeometryReader{ proxy in
            Group{
                if proxy.size.height > proxy.size.width {
                    VStack{
                        let size = UIImage(named: "\(sofha.id)")?.size
                        sofha.image
                            .renderingMode(colorScheme == .dark ? .template : .original)
                            .aspectRatio( isExtended ? proxy.size :  size! , contentMode: .fit)
                            .scaleEffect(x: isExtended ? 1.07 : 1)
                            .onTapGesture {
                                withAnimation(.easeInOut){
                                    isExtended.toggle()
                                }
                            }
                    }
                    .offset(y: 5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView{
                        VStack{
                            let size = UIImage(named: "\(sofha.id)")?.size

                            sofha.image
                                .aspectRatio( size! , contentMode: .fit)
                                .onTapGesture {
                                    withAnimation(.easeInOut){
                                        isExtended.toggle()
                                    }
                                }
                        }
                    }
                }
            }
            .overlay(alignment: .top) {
                NavigationButtomSheet {
                    QuranIndeView()
                } label: {
                    if let name = sofha.ayas.first?.sura.name {
                        Text(name)
                            .font(.waseem(25))
                    }
                }
                .opacity(isExtended ? 0 : 1)
                .offset(y: -5)
            }
        }
    }
}
