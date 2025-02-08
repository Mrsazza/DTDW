//
//  SubscriptionOptionsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct SubscriptionOptionsView: View {
    @State private var selectedButton: Int? = 1  // Default selection for monthly option
    @StateObject private var purchaseViewModel = PurchaseViewModel.shared
    
    var body: some View {
        VStack(spacing: 10) {
            SubscriptionOptionView(
                title: "\(purchaseViewModel.monthly) / month",
                subtitle: "Monthly Subscription",
                backgroundColor: selectedButton == 1 ? Color.subscriptionsColorButtonBackground : Color.white,
                isSelected: selectedButton == 1
            ) {
                selectedButton = 1
            }
            
            SubscriptionOptionView(
                title: "\(purchaseViewModel.annual) / year",
                subtitle: "Yearly Subscription",
                backgroundColor: selectedButton == 2 ? Color.subscriptionsColorButtonBackground : Color.white,
                isSelected: selectedButton == 2
            ) {
                selectedButton = 2
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 5)
    }
}
