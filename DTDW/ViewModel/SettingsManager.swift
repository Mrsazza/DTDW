//
//  SettingsManager.swift
//  DTDW
//
//  Created by Sopnil Sohan on 17/11/24.
//

import Foundation
import FirebaseDatabase

class SettingsManager: ObservableObject {
    @Published var enterEmail: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var showPremiumSubscriptions: Bool = false
    
    private let dbRef = Database.database().reference() // Realtime Database reference
    
    // Improved Email Validation
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: enterEmail)
    }
    
    // Subscribe to newsletter using Realtime Database
    func subscribeToNewsletter() {
        guard isValidEmail() else {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        // Create data to save
        let data: [String: Any] = [
            "email": enterEmail,
            "timestamp": Date().timeIntervalSince1970 // Save as Unix timestamp
        ]
        
        // Save to Realtime Database
        dbRef.child("newsletter_subscribers").childByAutoId().setValue(data) { [weak self] error, _ in
            DispatchQueue.main.async {
                if let error = error {
                    self?.alertMessage = "Failed to subscribe: \(error.localizedDescription)"
                } else {
                    self?.alertMessage = "Subscription successful! Thank you."
                    self?.enterEmail = "" // Clear input after success
                }
                self?.showAlert = true
            }
        }
    }
}

