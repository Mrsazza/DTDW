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
    @StateObject var purchaseTermsManager = PurchaseTermsManager()
    @StateObject var ongoingExpensesViewModel = OngoingExpensesManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .dynamicTypeSize(.medium)
                .environmentObject(purchaseTermsManager)
                .environmentObject(ongoingExpensesViewModel)
            
        }
    }
}
