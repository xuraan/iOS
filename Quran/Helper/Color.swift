//
//  Color.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension Color {
    
    static func favorite(_ condition: Bool) -> Color {
        condition ? .yellow : Color("BGI")
    }    
}
