//
//  File.swift
//  ProjectAIRBNB
//
//  Created by Iqbal Karim on 26.12.2022.
//

import Foundation

class Record {
    var name: String
    var category: String
    var description: String
    var image: String
    var location: String
    
    init() {
        self.category = ""
        self.name = ""
        self.description = ""
        self.image = ""
        self.location = ""
    }
    
    init(name: String, category: String, description: String, image: String, location: String) {
        self.category = category
        self.name = name
        self.description = description
        self.image = image
        self.location = location
    }
        
}
