//
//  SofhaView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct SofhaView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var sofha: Sofha
    @Binding var isExtended: Bool

    init(isExtended: Binding<Bool> = .constant(false) ,for sofha: Sofha) {
        self.sofha = sofha
        self._isExtended = isExtended
    }
    var body: some View {
        GeometryReader{ proxy in
            if proxy.size.height > proxy.size.width {
                VStack{
                    let size = UIImage(named: "test")?.size
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView{
                    VStack{
                        let size = UIImage(named: "test")?.size
                        sofha.image
                            .renderingMode(colorScheme == .dark ? .template : .original)
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

    }
}
