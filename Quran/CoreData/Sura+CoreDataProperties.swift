//
//  Sura+CoreDataProperties.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//
//

import Foundation
import CoreData


extension Sura {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sura> {
        return NSFetchRequest<Sura>(entityName: "Sura")
    }

    @NSManaged public var id: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String
    @NSManaged public var phonetic: String
    @NSManaged public var ayas: NSOrderedSet
    @NSManaged public var place: Place
    @NSManaged public var sofhas: NSOrderedSet
    @NSManaged public var kollections: NSSet

}

// MARK: Generated accessors for ayas
extension Sura {

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

// MARK: Generated accessors for sofhas
extension Sura {

    @objc(insertObject:inSofhasAtIndex:)
    @NSManaged public func insertIntoSofhas(_ value: Sofha, at idx: Int)

    @objc(removeObjectFromSofhasAtIndex:)
    @NSManaged public func removeFromSofhas(at idx: Int)

    @objc(insertSofhas:atIndexes:)
    @NSManaged public func insertIntoSofhas(_ values: [Sofha], at indexes: NSIndexSet)

    @objc(removeSofhasAtIndexes:)
    @NSManaged public func removeFromSofhas(at indexes: NSIndexSet)

    @objc(replaceObjectInSofhasAtIndex:withObject:)
    @NSManaged public func replaceSofhas(at idx: Int, with value: Sofha)

    @objc(replaceSofhasAtIndexes:withSofhas:)
    @NSManaged public func replaceSofhas(at indexes: NSIndexSet, with values: [Sofha])

    @objc(addSofhasObject:)
    @NSManaged public func addToSofhas(_ value: Sofha)

    @objc(removeSofhasObject:)
    @NSManaged public func removeFromSofhas(_ value: Sofha)

    @objc(addSofhas:)
    @NSManaged public func addToSofhas(_ values: NSOrderedSet)

    @objc(removeSofhas:)
    @NSManaged public func removeFromSofhas(_ values: NSOrderedSet)

}

// MARK: Generated accessors for kollections
extension Sura {

    @objc(addKollectionsObject:)
    @NSManaged public func addToKollections(_ value: Kollection)

    @objc(removeKollectionsObject:)
    @NSManaged public func removeFromKollections(_ value: Kollection)

    @objc(addKollections:)
    @NSManaged public func addToKollections(_ values: NSSet)

    @objc(removeKollections:)
    @NSManaged public func removeFromKollections(_ values: NSSet)

}

extension Sura : Identifiable {

}
