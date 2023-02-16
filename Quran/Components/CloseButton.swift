//
//  CloseButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) var dismiss
    var action: (()->Void)?
    var image: Image
    init(action: (()->Void)? = nil, icon: Image = Image(systemName: "xmark")) {
        self.action = action
        self.image = icon
    }
    var body: some View {
        Button(action: action ?? {dismiss()}, label: {
            image
                .font(.headline.weight(.bold))
                .foregroundColor(.accentColor)
                .frame(width: 40, height: 40)
                .background{
                    Circle()
                        .fill(.ultraThinMaterial.shadow(.inner(color: .accentColor.opacity(0.3), radius: 7)))
                }
                .padding(-1)
                .clipShape(Circle())
        })
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            CloseButton()
            CloseButton(icon: Image(systemName: "checkmark"))
        }
    }
}
