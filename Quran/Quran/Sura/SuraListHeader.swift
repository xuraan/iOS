//
//  SuraListHeader.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-12.
//

import SwiftUI

struct SuraListHeader: View {
    @Environment(\.editMode) var editMode
    var body: some View {
        HStack{
            if editMode?.wrappedValue == .active {
                HStack{}.frame(width: 35)
            }
            Text("Rank")
                .frame(width: 35, alignment: .leading)
            
            HStack{
                Text("Phonetic")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Translation")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("sura")
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

struct SuraListHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            SuraListHeader()
            SuraListHeader()
                .environment(\.editMode, .constant(.active))
        }
    }
}
