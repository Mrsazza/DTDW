//
//  PurchaseViewModel.swift
//  DTDW
//
//  Created by Sopnil Sohan on 6/2/25.
//

import SwiftUI
import Foundation
import RevenueCat

class PurchaseViewModel: ObservableObject {
    static let shared = PurchaseViewModel()
    
    private let revenueCatAPIKey = "Your RevenueCat API Key"
    
    @Published var isSubscribed: Bool = false
    
    @Published  var alertMessage = ""
    @Published  var errorMessage: String?
    @Published  var showAlert = false
    @Published var showMessage: Bool = false
    
    // Update these with your product identifiers
    var monthly: String = ""
    var annual: String = ""
    
    
private let revenueIdentifier = "Your RevenueCat Product ID"
    
    private init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: revenueCatAPIKey)
        fetchSubscriptionStatus()
        fetchLocalizedPrices()
    }
    
    // Check if the user has purchased the subscriptions
    func fetchSubscriptionStatus() {
        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
            if let error = error {
                print("Error fetching purchaser info: \(error.localizedDescription)")
                return
            }
            
            guard let purchaserInfo = purchaserInfo else {
                print("No purchaser info available")
                return
            }
            
            self.isSubscribed = purchaserInfo.entitlements.active.keys.contains("\(self.revenueIdentifier)")
        }
    }
    
    // Purchase the subscription with this function
    func purchaseSubscription(packageIdentifier: String, completion: @escaping (Bool) -> Void) {
        Purchases.shared.getOfferings { (offerings, error) in
            if let error = error {
                print("Error fetching offerings: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let offering = offerings?.current else {
                print("No current offering found")
                completion(false)
                return
            }

            // Print all available packages and their identifiers
            print("Available packages and identifiers:")
            for package in offering.availablePackages {
                print("Identifier: \(package.identifier), Price: \(package.localizedPriceString)")
            }

            guard let package = offering.availablePackages.first(where: { $0.identifier == packageIdentifier }) else {
                print("Package not found in offerings: \(packageIdentifier)")
                completion(false)
                return
            }

            Purchases.shared.purchase(package: package) { (transaction, purchaserInfo, error, userCancelled) in
                if let error = error {
                    print("Error purchasing: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                if userCancelled {
                    print("User cancelled the purchase")
                    completion(false)
                    return
                }

                if let purchaserInfo = purchaserInfo {
                    self.isSubscribed = purchaserInfo.entitlements.active.keys.contains("\(self.revenueIdentifier)")
                    completion(true)
                }
            }
        }
    }
    
    // Restore the previous purchase of the user
    func restorePurchases(completion: @escaping (Bool) -> Void) {
        Purchases.shared.restorePurchases { (purchaserInfo, error) in
            if let error = error {
                print("Error restoring purchases: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let purchaserInfo = purchaserInfo {
                self.isSubscribed = purchaserInfo.entitlements.active.keys.contains("\(self.revenueIdentifier)")
                completion(purchaserInfo.entitlements.active.keys.contains("\(self.revenueIdentifier)"))
            }
        }
    }
    
    // Fetch the price of each offering
    func fetchLocalizedPrices() {
        Purchases.shared.getOfferings { (offerings, error) in
            guard let offering = offerings?.current else {
                print("No current offering available: \(String(describing: error?.localizedDescription))")
                return
            }
            // Print all available packages
            print("Available packages and identifiers:")
            for package in offering.availablePackages {
                print("Identifier: \(package.identifier), Price: \(package.localizedPriceString)")
            }
            
            if let monthly = offering.monthly?.localizedPriceString {
                self.monthly = monthly
            }

            if let annual = offering.annual?.localizedPriceString {
                self.annual = annual
            }
        }
    }
    
    // Handle restore purchases
    func confirmRestorePurchas() {
        restorePurchases { success in
            if success {
                self.alertMessage = "Package successfully restored."
            } else {
                self.alertMessage = "Nothing to restore."
            }
            self.showAlert = true
        }
    }
}
 
