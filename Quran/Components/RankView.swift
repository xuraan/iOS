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
                .overlay {
                    Text(text)
                        .font(.system(size: 17).bold())
                        .foregroundColor(color)
                        .minimumScaleFactor(0.3)
                        .frame(width: 30)
                }
        }
    }
}


struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView(text: "45:78")
    }
}
