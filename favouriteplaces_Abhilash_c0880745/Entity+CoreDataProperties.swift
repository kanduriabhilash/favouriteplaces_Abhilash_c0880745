//
//  Entity+CoreDataProperties.swift
//  favouriteplaces_Abhilash_c0880745
//
//  Created by user223764 on 1/24/23.
//
//
//import favourite
import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension Entity : Identifiable {

}
