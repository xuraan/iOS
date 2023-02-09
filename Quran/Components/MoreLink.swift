//
//  MoreLink.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct MoreLink<Destination: View>: View {
    var destination: Destination
    init(@ViewBuilder destination: @escaping ()-> Destination) {
        self.destination = destination()
    }
    var body: some View {
        NavigationLink(destination: destination, label: {
            HStack{
                Text("More")
                Image(systemName: "arrow.up.right.circle.fill")
            }
            .font(.footnote)
        })
    }
}

struct MoreLinkSheet<Content: View>: View {
    var content: Content
    @State var show = false
    init(@ViewBuilder content: @escaping ()-> Content) {
        self.content = content()
    }
    var body: some View {
        Button(action: {show = true}){
            HStack{
                Text("More")
                Image(systemName: "arrow.up.right.circle.fill")
            }
            .font(.footnote)
        }
        .customDismissibleSheet(isPresented: $show) {
            content
        }
    }
}

struct MoreLink_Previews: PreviewProvider {
    static var previews: some View {
        MoreLink{
            
        }
        MoreLinkSheet {
            List{
                
            }
        }
    }
}
