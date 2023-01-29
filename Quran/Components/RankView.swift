//
//  RankView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

struct RankView: View {
    var text: String
    var color: Color
    var bgColor: Color
    init(text: String = "1", color: Color = .white, bgColor: Color = .yellow) {
        self.text = text
        self.color = color
        self.bgColor = bgColor
    }
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(bgColor)
            
            Text(text)
                .font(.system(size: 17))
                .minimumScaleFactor(0.1)
                .foregroundColor(color)
                .frame(width: 37)
                .lineLimit(1)
                .bold()
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            RankView()
            RankView(text: "90:1", color: .white, bgColor: .accentColor)
            RankView(text: "90:90")
        }
    }
}

