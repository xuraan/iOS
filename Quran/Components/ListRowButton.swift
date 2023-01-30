//
//  ListRowButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

struct ListRowButton<Label:View>: View {
    var action: ()->Void
    var label: ()->Label
    init(action: @escaping () -> Void, label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }
    var body: some View {
        Button(action: action){
            label()
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .buttonStyle(RowButtonStyle())
    }
}

