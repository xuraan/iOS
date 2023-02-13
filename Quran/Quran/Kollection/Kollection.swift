//
//  Kollection.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//

import SwiftUI

extension Kollection  {
    static func request(for id: String) -> FetchRequest<Kollection> {
        let request = fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Kollection.id, ascending: true)
        ]
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id = %@", id)
        return FetchRequest(fetchRequest: request)
    }
    ///return the ids of immutable Kollection like favorites ...
    static var immutableIDs: [String] = [favoriteID]
    static var favoriteID = "C6819E4A-9203-48CE-9EE4-AAF815B52D09"
    static var predicate = NSPredicate(format: "NOT (id IN %@)", immutableIDs)
    static var favoritePredicate = NSPredicate(format: "id = %@", favoriteID)
}

extension Kollection {
    func contains<T>(object: T) -> Bool {
        if T.self == Sura.self {
            return suras.contains(object)
        } else if T.self == Sofha.self {
            return sofhas.contains(object)
        } else if T.self == Aya.self {
            return ayas.contains(object)
        }
        return false
    }
    var count: Int { suras.count + ayas.count + sofhas.count }
    var color: Color { Color(hex: colorHex) ?? .black }
}
