//
//  PlaceCore+CoreDataProperties.swift
//  
//
//  Created by Iqbal Karim on 27.12.2022.
//
//

import Foundation
import CoreData


extension PlaceCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceCore> {
        return NSFetchRequest<PlaceCore>(entityName: "PlaceCore")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var desc: String?
    @NSManaged public var category: String?

}
