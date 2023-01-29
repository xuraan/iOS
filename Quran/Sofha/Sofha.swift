//
//  Sofha.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI

//MARK: - Image
extension Sofha {
    var image: Image {
        Image("test")
            .resizable()
    }
    var iconColor: Color { self.isFavorite ? .yellow : Color("BGI")}

}
