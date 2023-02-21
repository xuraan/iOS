//
//  RankView.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-21.
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
            Image(systemName: "circle.fill")
                .font(.largeTitle)
                .foregroundColor(bgColor)
            
            Text(text)
                .font(.system(size: 17))
                .minimumScaleFactor(0.1)
                .foregroundColor(color)
                .frame(width: 45)
                .lineLimit(1)
                .bold()
        }
    }
}


struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView(text: "45")
    }
}
