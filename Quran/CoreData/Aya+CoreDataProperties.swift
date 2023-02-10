//
//  Aya+CoreDataProperties.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//
//

import Foundation
import CoreData


extension Aya {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aya> {
        return NSFetchRequest<Aya>(entityName: "Aya")
    }

    @NSManaged public var id: Int16
    @NSManaged public var plain: String
    @NSManaged public var text: String
    @NSManaged public var sofha: Sofha
    @NSManaged public var sura: Sura
    @NSManaged public var kollections: NSSet

}

// MARK: Generated accessors for kollections
extension Aya {

    @objc(addKollectionsObject:)
    @NSManaged public func addToKollections(_ value: Kollection)

    @objc(removeKollectionsObject:)
    @NSManaged public func removeFromKollections(_ value: Kollection)

    @objc(addKollections:)
    @NSManaged public func addToKollections(_ values: NSSet)

    @objc(removeKollections:)
    @NSManaged public func removeFromKollections(_ values: NSSet)

}

extension Aya : Identifiable {

}
