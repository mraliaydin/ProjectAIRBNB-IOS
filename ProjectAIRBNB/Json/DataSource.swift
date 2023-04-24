//
//  DataSource.swift
//  ProjectAIRBNB
//
//  Created by Iqbal Karim on 26.12.2022.
//

import Foundation

class DataSource {
    var mRecordList: [Record] = []
    var categories: [String] = []
    
    func numbeOfItemsInEachCategory(index: Int) -> Int {
        return itemsInCategory(index: index).count
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func getCategoryLabelAtIndex(index: Int) -> String {
        return categories[index]
    }
    
    // MARK: - Populate Data from files
    func populate() {
        
        if let path = Bundle.main.path(forResource: "houses", ofType: "json") {
            if let jsonToParse = NSData(contentsOfFile: path) {
                
                guard let json = try? JSON(data: jsonToParse as Data) else {
                    print("Error with JSON")
                    return
                }
                let total = json["houses"].count
                
                for index in 0..<total {
                    if let name = json["houses"][index]["name"].string, let desc = json["houses"][index]["description"].string, let category = json["houses"][index]["category"].string, let image = json["houses"][index]["img"].string, let location = json["houses"][index]["location"].string {
                        
                        let mRecord = Record(name: name, category: category, description: desc, image: image, location: location)
                        mRecordList.append(mRecord)
                        
                        if !categories.contains(category) {
                            categories.append(category)
                        }
                    }
                    else {
                        print("Error occurred during optional unwrapping")
                    }
                }
            }
            else {
                print("NSdata error")
            }
        }
        else {
            print("NSURL error")
        }
        
    }

        
    // MARK: - itemsForEachGroup
    func itemsInCategory(index: Int) -> [Record] {
        let item = categories[index]
        
        // See playground6 for Closure
        // http://locomoviles.com/uncategorized/filtering-swift-array-dictionaries-object-property/
        
        let filteredItems = mRecordList.filter { (record: Record) -> Bool in
            return record.category == item
        }
        return filteredItems
    }
    
    func getAllItems() -> [Record] {
        return mRecordList
    }
}
