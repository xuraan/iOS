//
//  LoadData.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//

import SwiftUI

//MARK: - Bundle
extension Bundle {
    func decodeQuran(_ file: String) -> [SuraUtils] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            ErrorHandler.shared.errorMessage = "Failed to locate \(file) in bundle."
            return []
        }

        guard let data = try? Data(contentsOf: url) else {
            ErrorHandler.shared.errorMessage = "Failed to load \(file) from bundle."
            return []
        }

        let decoder = JSONDecoder()

        do {
            let loaded = (try decoder.decode([SuraUtils].self, from: data))
            return loaded
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            ErrorHandler.shared.handle(nsError)
            return []
        }
        

    }
}

//MARK: - Helpers
struct SuraUtils: Codable, Identifiable {
    let id: Int16
    let name: String
    let phonetic: String
    let place: String
    let ayas: [AyaUtils]
}

struct AyaUtils: Codable, Identifiable {
    let id: Int16
    let text: String
    let sofha: Int16
    let plain: String
}
