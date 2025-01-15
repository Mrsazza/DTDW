//
//  PremiumSubscriptionsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct DWDTPremiumSubscriptionsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                //Top Navigation Bar
                HStack(alignment: .top, spacing: 40) {
                    Button(action: {
                        // Back button action
                        dismiss() 
                    }) {
                        Image("Chevron left")
                            .resizable()
                            .scaledToFill()
                            .fontWeight(.bold)
                            .frame(width: 30, height: 30)
                    }
                    
                    // Premium Subscription Image
                    Image("Premium Sub Image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 232,height: 138)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                // Premium Section
                VStack(spacing: 20) {
                    PremiumSectionTitleView(title: "Premium Version")
                        .foregroundStyle(Color.deepPurpelColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    
                    VStack(spacing: 10) {
                        RectangleDashLine()
                            .padding(.horizontal, 20)
                        // Features List
                        PremiumFeaturesView()
                        
                        RectangleDashLine()
                            .padding(.horizontal, 20)
                    }
                    
                    // Subscription Options
                    SubscriptionOptionsView()
                    
                    // Upgrade Button
                    PremiumGradientButton(title: "Upgrade Premium") {
                        // Upgrade button action
                    }
                    
                    // Restore Purchases
                    Button {
                        
                    } label: {
                        Text("Restore Purchases")
                            .foregroundStyle(Color.deepPurpelColor)
                            .font(.system(size: 18))
                    }
                    
                    // Legal Links
                    LegalLinksView()
                    
                    // Payment Information Text
                    Text("Payment will be charged to your iTunes account at confirmation of purchase. Subscription will automatically renew unless auto-renew is turned off at least 24 hours before the end of the current period. Your account will be charged according to your plan for renewal within 24 hours prior to the end of the current period. You can manage or turn off auto-renew in your Apple ID account settings at any time after purchase.")
                        .foregroundStyle(Color.deepPurpelColor)
                        .font(.system(size: 12))
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.white)
                .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20))
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

#Preview {
    DWDTPremiumSubscriptionsView()
}


