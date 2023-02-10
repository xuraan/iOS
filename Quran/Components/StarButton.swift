//
//  StarButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct StarButton: View {
    @Environment(\.isDestructive) var isDestructive
    var isStared: Bool
    var action: ()->Void
    init(isStared: Bool, action: @escaping () -> Void) {
        self.isStared = isStared
        self.action = action
    }
    var body: some View {
        Button( role: isDestructive ? .destructive : .cancel , action: action){
            if isStared {
                Label("Unstar", systemImage: "star.slash")
            } else {
                Label("Star", systemImage: "star")
            }
        }
        .tint(.yellow)
    }
}
