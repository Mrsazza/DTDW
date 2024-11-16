//
//  SettingsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var enterEmail: String = ""
    @State private var showPremiumSubscriptions = false  // State variable to show modal sheet
    
    var placeholder: String = "Your email address"
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                Text("Settings")
                    .foregroundStyle(.black)
                    .font(.system(size: 26, weight: .bold))
                
                // Divider
                DividerView()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Premium Version Section
                        SectionTitleView(title: "Premium Version")
                        
                        PremiumInfoView()
                        
                        // View Plan Button with sheet presentation
                        GradientButton(title: "View Plan") {
                            showPremiumSubscriptions = true  // Set to true to show the sheet
                        }
                        .fullScreenCover(isPresented: $showPremiumSubscriptions) {
                            PremiumSubscriptionsView()  // Full-screen modal view
                        }
                        
                        // Divider
                        DividerView()
                        
                        // Upgrade Premium Section
                        SettingOptionRow(title: "Upgrade Premium", icon: "Premium Icon", action: { print("Upgrade Premium tapped") })
                            .padding([.top, .bottom], 10)
                        
                        // Email Input and Newsletter Subscription
                        VStack(spacing: 20) {
                            Text("Receive Updates From The Landlady")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.black)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            TextField(placeholder, text: $enterEmail)
                                .textFieldStyle(DefaultTextFieldStyle())
                                .foregroundStyle(Color.black)
                            
                            GradientButton(title: "Subscribe to Newsletter", action: { print("Subscribe tapped") })
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(radius: 4)
                        
                        // Divider
                        DividerView()
                        
                        // Additional Options
                        VStack(spacing: 10) {
                            SettingOptionRow(title: "Restore Purchases", icon: "Restore Purchases Icon", action: { print("Restore Purchases tapped") })
                            SettingOptionRow(title: "Rate App", icon: "Star Icon", action: { print("Rate App tapped") })
                            SettingOptionRow(title: "Share App", icon: "Share Icon", action: { print("Share App tapped") })
                        }
                        
                        // Divider
                        DividerView()
                        
                        // Support and Policy Links
                        VStack(spacing: 10) {
                            SettingOptionRow(title: "Email us", icon: "Email Icon", action: { print("Email us tapped") })
                            SettingOptionRow(title: "Privacy Policy", icon: "Privacy Icon", action: { print("Privacy Policy tapped") })
                            SettingOptionRow(title: "Terms of Use", icon: "Terms Icon", action: { print("Terms of Use tapped") })
                                .padding(.bottom, 110)
                        }
                    }
                }
                .background(.white)
                .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight], radius: 20))
                .padding(.horizontal, 15)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 0)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

#Preview {
    SettingsView()
}
