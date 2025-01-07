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
            PropertyData.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // Create a default PropertyData instance to pass to ContentView
    var defaultPropertyData: PropertyData = {
        let demoCalculatableData = demoPropertyCalculatableData // Use your demo instance
        return PropertyData(
            id: UUID().uuidString, // Convert UUID to String
            propertyName: "Default Property",
            imageData: nil,
            propertyCalculatabeleData: demoCalculatableData
        )
    }()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(propertyData: defaultPropertyData) // Pass the instance here
                .dynamicTypeSize(.medium)
                .modelContainer(sharedModelContainer)
                .modelContainer(for: [PropertyData.self])
        }
    }
}

