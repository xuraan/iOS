//
//  PinnedButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

struct PinnedButton: View {
    @Environment(\.isPennedDestructive) var isDestructive
    var isPinned: Bool
    var action: ()->Void
    init(isPinned: Bool, action: @escaping () -> Void) {
        self.isPinned = isPinned
        self.action = action
    }
    var body: some View {
        Button( role: isDestructive ? .destructive : .cancel , action: action){
            if isPinned {
                Label("UnPin", systemImage: "pin.slash")
            } else {
                Label("Pin", systemImage: "pin")
            }
        }
        .tint(.gray)
    }
}
struct PinnedButton_Previews: PreviewProvider {
    static var previews: some View {
        PinnedButton(isPinned: false, action: {})
        PinnedButton(isPinned: true, action: {})
    }
}
