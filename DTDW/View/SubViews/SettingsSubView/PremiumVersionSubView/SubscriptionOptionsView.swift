//
//  SubscriptionOptionsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 13/11/24.
//

import SwiftUI

struct SubscriptionOptionsView: View {
    @State private var selectedButton: Int? = 1  // Default selection for monthly option
    
    var body: some View {
        VStack(spacing: 10) {
            SubscriptionOptionView(
                title: "$2.99 / month",
                subtitle: "Monthly Subscription",
                backgroundColor: selectedButton == 1 ? Color.subscriptionsColorButtonBackground : Color.white,
                isSelected: selectedButton == 1
            ) {
                selectedButton = 1
            }
            
            SubscriptionOptionView(
                title: "$32.99 / year",
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
