//
//  Untitled.swift
//  DTDW
//
//  Created by Sazza on 16/12/24.
//

import Foundation
import SwiftData

@Model
class PropertyData {
    @Attribute(.unique)
    var id: String
    var propertyName: String
    @Attribute(.externalStorage)
    var imageData: Data?
    var propertyCalculatabeleData: PropertyCalculatableData?
   
    init(id: String = UUID().uuidString, propertyName: String, imageData: Data? = nil, propertyCalculatabeleData: PropertyCalculatableData? = nil) {
        self.id = id
        self.propertyName = propertyName
        self.imageData = imageData
        self.propertyCalculatabeleData = propertyCalculatabeleData
    }
}


