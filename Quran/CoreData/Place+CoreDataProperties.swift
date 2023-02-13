//
//  Place+CoreDataProperties.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-12.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var id: String
    @NSManaged public var suras: NSOrderedSet

}

// MARK: Generated accessors for suras
extension Place {

    @objc(insertObject:inSurasAtIndex:)
    @NSManaged public func insertIntoSuras(_ value: Sura, at idx: Int)

    @objc(removeObjectFromSurasAtIndex:)
    @NSManaged public func removeFromSuras(at idx: Int)

    @objc(insertSuras:atIndexes:)
    @NSManaged public func insertIntoSuras(_ values: [Sura], at indexes: NSIndexSet)

    @objc(removeSurasAtIndexes:)
    @NSManaged public func removeFromSuras(at indexes: NSIndexSet)

    @objc(replaceObjectInSurasAtIndex:withObject:)
    @NSManaged public func replaceSuras(at idx: Int, with value: Sura)

    @objc(replaceSurasAtIndexes:withSuras:)
    @NSManaged public func replaceSuras(at indexes: NSIndexSet, with values: [Sura])

    @objc(addSurasObject:)
    @NSManaged public func addToSuras(_ value: Sura)

    @objc(removeSurasObject:)
    @NSManaged public func removeFromSuras(_ value: Sura)

    @objc(addSuras:)
    @NSManaged public func addToSuras(_ values: NSOrderedSet)

    @objc(removeSuras:)
    @NSManaged public func removeFromSuras(_ values: NSOrderedSet)

}

extension Place : Identifiable {

}
