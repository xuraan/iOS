//
//  CustomList.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-31.
//

import SwiftUI

struct CustomList<Content: View>: View {
    var content: Content
    init(@ViewBuilder content: @escaping ()->Content) {
        self.content = content()
    }
    var body: some View {
        List{
            content
        }
    }
}

struct CustomList_Previews: PreviewProvider {
    static var previews: some View {
        CustomList{
            
        }
    }
}
