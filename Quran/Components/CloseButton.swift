//
//  CloseButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct CloseButton: View{
    @Environment(\.dismiss) var dismiss
    var action: (()->Void)?
    
    init(action: (()->Void)? = nil ) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action ?? {dismiss()}, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(width: 40, height: 40)
                .background{
                    Circle()
                        .fill(.ultraThinMaterial.shadow(.inner(color: .primary.opacity(0.1), radius: 5)))
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
