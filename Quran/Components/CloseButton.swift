//
//  CloseButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) var dismiss
    var action: (()->Void)?
    var image: Image
    
    var font: Font
    init(action: (()->Void)? = nil, icon: Image = Image(systemName: "xmark"), font: Font = .headline.weight(.bold)) {
        self.action = action
        self.image = icon
        
        self.font = font
    }
    var body: some View {
        Button(action: action ?? {dismiss()}, label: {
            image
                .font(font)
                .foregroundColor(.accentColor)
//                .frame(width: 40, height: 40)
            
                .padding(12)
                .background {
                    Circle()
                        .fill(.ultraThinMaterial.shadow(.inner(color: .accentColor.opacity(0.1), radius: 5)))
                }
                .padding(-1)
                .clipShape(Circle())
        })
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
