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
    @Attribute(.unique) // Ensures uniqueness of the ID
    var id: String

    var propertyName: String

    @Attribute(.externalStorage) // For efficient handling of potentially large image data
    var imageData: Data?
    
    var cashOnCashReturn: Double = 0.0

    var propertyCalculatabeleData: PropertyCalculatableData

    // SwiftData requires an explicit initializer if custom initializations are needed.
    init(
        id: String = UUID().uuidString,
        propertyName: String,
        imageData: Data? = nil,
        propertyCalculatabeleData: PropertyCalculatableData
    ) {
        self.id = id
        self.propertyName = propertyName
        self.imageData = imageData
        self.propertyCalculatabeleData = propertyCalculatabeleData
    
    }
}


