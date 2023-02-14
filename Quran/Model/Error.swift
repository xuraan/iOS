//
//  Error.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-14.
//

import SwiftUI

class ErrorHandler: ObservableObject {
    static var shared = ErrorHandler()
    @Published var errorMessage: String = ""
    func handle(_ error: Error) {
        errorMessage = error.localizedDescription
    }
}
