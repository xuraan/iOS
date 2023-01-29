//
//  StarButton.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

struct StarButton: View{
    var action: ()-> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            Label(title: {
                Text("Star")
            }, icon: {
                Image(systemName: "star")
                    .font(.title)
            })
        })
        .tint(.yellow)
    }
}

struct UnstarButton: View{
    @Environment(\.isDestructive) var isDestructive
    var action: ()-> Void
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(role: isDestructive ? .destructive : .cancel, action: action, label: {
            Label(title: {
                Text("Unstar")
            }, icon: {
                Image(systemName: "star.slash")
                    .font(.title)
            })
        })
        .tint(.yellow)
    }
}


struct StarButton_Previews: PreviewProvider {
    static var previews: some View {
        StarButton{
            
        }
        
        UnstarButton{
            
        }
    }
}

