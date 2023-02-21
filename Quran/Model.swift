//
//  Model.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-20.
//

import SwiftUI

class Model: ObservableObject {
    @Published var tokens = [SearchToken]()
    
}


enum SearchToken {
    case sura, aya, sofha, hizb
}
