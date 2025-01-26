//
//  DTDWApp.swift
//  DTDW
//
//  Created by Sazza on 5/11/24.
//
import SwiftUI
import Firebase
import SwiftData

@main
struct DTDWApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PropertyDataModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // Create a default PropertyData instance to pass to ContentView
    var defaultPropertyData: PropertyDataModel = {
        let demoCalculatableData = demoPropertyCalculatableData
        return PropertyDataModel( propertyName: "Land Lady Apt",propertyCalculatabeleData: demoCalculatableData
)
    }()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            DTDWTabView(propertyData: defaultPropertyData)
                .dynamicTypeSize(.medium)
                .modelContainer(sharedModelContainer)
//                .modelContainer(for: [PropertyData.self])
        }
    }
}
