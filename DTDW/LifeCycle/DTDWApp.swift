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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .dynamicTypeSize(.medium)
                .environmentObject(PurchaseTermsManager())
                .environmentObject(OngoingExpensesManager())
                .modelContainer(sharedModelContainer)
            
        }
    }
}
