//
//  PremiumSubscriptionsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct DWDTPremiumSubscriptionsView: View {
    @StateObject private var purchaseViewModel = PurchaseViewModel.shared
    @Environment(\.dismiss) private var dismiss
    @State private var selectedButton: Int? = 1
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack(alignment: .top, spacing: 40) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("Chevron left")
                            .resizable()
                            .scaledToFill()
                            .fontWeight(.bold)
                            .frame(width: 30, height: 30)
                    }
                    
                    Image("Premium Sub Image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 232,height: 138)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                
                //MARK: Premium Section
                VStack(spacing: 20) {
                    PremiumSectionTitleView(title: "Premium Version")
                        .foregroundStyle(Color.deepPurpelColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    
                    VStack(spacing: 10) {
                        RectangleDashLine()
                            .padding(.horizontal, 20)
                        
                        PremiumFeaturesView()
                        
                        RectangleDashLine()
                            .padding(.horizontal, 20)
                    }
                    
                    //MARK: Subscription Options
                    SubscriptionOptionsView()
                    
                    VStack(spacing: 3) {
                        if let errorMessage = purchaseViewModel.errorMessage {
                            Text(errorMessage)
                                .font(.system(size: 8))
                                .foregroundColor(.red)
                        } else {
                            Text("Secured with App Store. Cancel anytime")
                                .font(.system(size: 8))
                                .foregroundColor(.customErrorMessageForeground)
                                .animation(.easeIn)
                        }
                        
                        //MARK: Upgrade Button
                        PremiumGradientButton(title: "Upgrade Premium") {
                            confirmSubscription()
                        }
                    }
                    
                    //MARK: Restore Purchases
                    Button {
                        PurchaseViewModel.shared.confirmRestorePurchas()
                    } label: {
                        Text("Restore Purchases")
                            .foregroundStyle(Color.deepPurpelColor)
                            .font(.system(size: 18))
                    }
                    
                    //MARK: Legal Links
                    LegalLinksView()
                    
                    //MARK: Payment Information Text
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
    // Handle subscription confirmation
    private func confirmSubscription() {
        guard let selectedButton = selectedButton else { return }
        let packageIdentifier: String
        
        switch selectedButton {
        case 1:
            packageIdentifier = "$rc_monthly"
        case 2:
            packageIdentifier = "$rc_annual"
        default:
            return
        }
        
        purchaseViewModel.purchaseSubscription(packageIdentifier: packageIdentifier) { success in
            if success {
                print("Subscription successful!")
                presentationMode.wrappedValue.dismiss()
            } else {
                print("Subscription failed.")
                purchaseViewModel.errorMessage = "Subscription failed. Please try again."
            }
        }
    }
}
