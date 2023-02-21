//
//  Color.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

extension Color {
    static let keyboard: Color = Color("keyboard")
    static func favorite(_ condition: Bool) -> Color{
        condition ? .yellow : Color("BGI")
    }
}
