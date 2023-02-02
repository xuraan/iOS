//
//  Sura.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-26.
//

import SwiftUI
import CoreData



extension Sura {
    var translation : String { NSLocalizedString( "s\(self.id)", tableName: "suras", comment: "sura trans")}
    var iconColor: Color { self.isFavorite ? .yellow : Color("BGI")}
}
