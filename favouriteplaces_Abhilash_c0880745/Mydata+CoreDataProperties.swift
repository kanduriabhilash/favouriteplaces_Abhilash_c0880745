//
//  Mydata+CoreDataProperties.swift
//  favouriteplaces_Abhilash_c0880745
//
//  Created by user223764 on 1/
import Foundation
import CoreData


extension Mydata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mydata> {
        return NSFetchRequest<Mydata>(entityName: "Mydata")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension Mydata : Identifiable {

}
