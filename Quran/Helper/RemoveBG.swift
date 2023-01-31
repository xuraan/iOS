//
//  RemoveBG.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

struct RemoveBG: UIViewRepresentable{
    
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
        }
    }
}
struct RemoveBG_Previews: PreviewProvider {
    static var previews: some View {
        Color.red
            .fullScreenCover(isPresented: .constant(true)){
                VStack{
                    
                }
                .background{
                    RemoveBG()
                }
            }
    }
}
