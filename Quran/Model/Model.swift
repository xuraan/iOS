//
//  Model.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-30.
//

import SwiftUI

class Model: ObservableObject {
    
    //MARK: - Kollection
    @Published var Kollection: Kollection?
    @Published var showAddCollection: Bool = false

    //MARK: - global
    @Published var preferredColorScheme: ColorScheme?
}
