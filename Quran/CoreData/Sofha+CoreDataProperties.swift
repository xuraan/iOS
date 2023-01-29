//
//  Sofha+CoreDataProperties.swift
//  Quran
//
//  Created by Samba Diawara on 2023-01-27.
//
//

import Foundation
import CoreData


extension Sofha {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sofha> {
        return NSFetchRequest<Sofha>(entityName: "Sofha")
    }

    @NSManaged public var id: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var ayas: NSOrderedSet
    @NSManaged public var suras: NSOrderedSet

}

// MARK: Generated accessors for ayas
extension Sofha {

    @objc(insertObject:inAyasAtIndex:)
    @NSManaged public func insertIntoAyas(_ value: Aya, at idx: Int)

    @objc(removeObjectFromAyasAtIndex:)
    @NSManaged public func removeFromAyas(at idx: Int)

    @objc(insertAyas:atIndexes:)
    @NSManaged public func insertIntoAyas(_ values: [Aya], at indexes: NSIndexSet)

    @objc(removeAyasAtIndexes:)
    @NSManaged public func removeFromAyas(at indexes: NSIndexSet)

    @objc(replaceObjectInAyasAtIndex:withObject:)
    @NSManaged public func replaceAyas(at idx: Int, with value: Aya)

    @objc(replaceAyasAtIndexes:withAyas:)
    @NSManaged public func replaceAyas(at indexes: NSIndexSet, with values: [Aya])

    @objc(addAyasObject:)
    @NSManaged public func addToAyas(_ value: Aya)

    @objc(removeAyasObject:)
    @NSManaged public func removeFromAyas(_ value: Aya)

    @objc(addAyas:)
    @NSManaged public func addToAyas(_ values: NSOrderedSet)

    @objc(removeAyas:)
    @NSManaged public func removeFromAyas(_ values: NSOrderedSet)

}

// MARK: Generated accessors for suras
extension Sofha {

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

extension Sofha : Identifiable {

}
