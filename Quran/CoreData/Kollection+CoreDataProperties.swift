//
//  Kollection+CoreDataProperties.swift
//  Quran
//
//  Created by Samba Diawara on 2023-02-09.
//
//

import Foundation
import CoreData


extension Kollection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kollection> {
        return NSFetchRequest<Kollection>(entityName: "Kollection")
    }

    @NSManaged public var id: String
    @NSManaged public var ayas: NSSet
    @NSManaged public var suras: NSSet
    @NSManaged public var sofhas: NSSet

}

// MARK: Generated accessors for ayas
extension Kollection {

    @objc(addAyasObject:)
    @NSManaged public func addToAyas(_ value: Aya)

    @objc(removeAyasObject:)
    @NSManaged public func removeFromAyas(_ value: Aya)

    @objc(addAyas:)
    @NSManaged public func addToAyas(_ values: NSSet)

    @objc(removeAyas:)
    @NSManaged public func removeFromAyas(_ values: NSSet)

}

// MARK: Generated accessors for suras
extension Kollection {

    @objc(addSurasObject:)
    @NSManaged public func addToSuras(_ value: Sura)

    @objc(removeSurasObject:)
    @NSManaged public func removeFromSuras(_ value: Sura)

    @objc(addSuras:)
    @NSManaged public func addToSuras(_ values: NSSet)

    @objc(removeSuras:)
    @NSManaged public func removeFromSuras(_ values: NSSet)

}

// MARK: Generated accessors for sofhas
extension Kollection {

    @objc(addSofhasObject:)
    @NSManaged public func addToSofhas(_ value: Sofha)

    @objc(removeSofhasObject:)
    @NSManaged public func removeFromSofhas(_ value: Sofha)

    @objc(addSofhas:)
    @NSManaged public func addToSofhas(_ values: NSSet)

    @objc(removeSofhas:)
    @NSManaged public func removeFromSofhas(_ values: NSSet)

}

extension Kollection : Identifiable {

}
