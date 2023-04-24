//
//  PlaceCore+CoreDataClass.swift
//  
//
//  Created by Iqbal Karim on 27.12.2022.
//
//

import Foundation
import CoreData

@objc(PlaceCore)
public class PlaceCore: NSManagedObject {
    class func createInManagedObjectContext(_ context: NSManagedObjectContext, name: String, location: String, category: String, img: String, desc: String ) -> PlaceCore {
        let placeObj = NSEntityDescription.insertNewObject(forEntityName: "PlaceCore", into: context) as! PlaceCore
        placeObj.name = name
        placeObj.desc = desc
        placeObj.image = img
        placeObj.category = category
        placeObj.location = location
        
        return placeObj
    }
}
