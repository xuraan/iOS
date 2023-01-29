//
//  Aya+CoreDataProperties.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//
//

import Foundation
import CoreData


extension Aya {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aya> {
        return NSFetchRequest<Aya>(entityName: "Aya")
    }

    @NSManaged public var id: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var plain: String
    @NSManaged public var text: String
    @NSManaged public var sofha: Sofha
    @NSManaged public var sura: Sura

}

extension Aya : Identifiable {

}
