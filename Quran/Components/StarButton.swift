//
//  StarButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
//

import SwiftUI

struct StarButton<T>: View {
    @Environment(\.isDestructiveStarButton) var isDestructive
    @ObservedObject var favorite: Kollection = KollectionProvider.favorite
    var object: T
    init(_ object: T){
        self.object = object
    }
    var body: some View {
        Button{
            favorite.toggle(object)
        } label: {
            Label(title: {
                Text(favorite.contains(object) ? "Unstar" : "Star")
            }, icon: {
                Image(systemName: favorite.contains(object) ? "star.slash" : "star")
            })
        }.tint(.yellow)
    }
}

//MARK: - Destructive EnvKey
struct IsDestructiveStarButtonKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var isDestructiveStarButton: Bool {
        get{self[IsDestructiveStarButtonKey.self]}
        set{self[IsDestructiveStarButtonKey.self] = newValue }
    }
}

struct StarButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            StarButton(QuranProvider.shared.aya(2))
        }
    }
}

