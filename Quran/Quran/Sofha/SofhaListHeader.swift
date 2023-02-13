//
//  SofhaListHeader.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-12.
//

import SwiftUI

struct SofhaListHeader: View {
    @Environment(\.editMode) var editMode
    var body: some View {
        HStack{
            if editMode?.wrappedValue == .active {
                HStack{}.frame(width: 35)
            }
            Text("Page")
                .frame(width: 35, alignment: .leading)

            HStack{
                
                Text("Last aya")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text("First aya")
                    .frame(maxWidth: .infinity, alignment: .trailing)

            }
            .environment(\.layoutDirection, .leftToRight)

            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding( .bottom, 5)
        .frame(height: 20)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.horizontal)
        .background(.bar)
        .overlay(alignment: .bottom){
            Divider()
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}

struct SofhaListHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            SofhaListHeader()
            SofhaListHeader()
                .environment(\.editMode, .constant(.active))
        }
    }
}
