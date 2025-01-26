//
//  SettingsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI

struct DTDWSettingsView: View {
    @StateObject private var settingsManager = SettingsManager() // ViewModel

    var placeholder: String = "Your email address"

    var body: some View {
        ZStack {
            // Background color
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

                        // View Plan Button
                        GradientButton(title: "View Plan") {
                            settingsManager.showPremiumSubscriptions = true
                        }
                        .fullScreenCover(isPresented: $settingsManager.showPremiumSubscriptions) {
                            DWDTPremiumSubscriptionsView()
                        }

                        // Divider
                        DividerView()

                        // Upgrade Premium Section
                        SettingOptionRow(title: "Upgrade Premium", icon: "Premium Icon", action: {
                            print("Upgrade Premium tapped")
                        })
                        .padding([.top, .bottom], 10)

                        // Email Input and Newsletter Subscription
                        VStack(spacing: 20) {
                            Text("Receive Updates From The Landlady")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.black)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            NewsletterCustomTextField(text: $settingsManager.enterEmail, placeholder: placeholder,placeholderColor: .gray,textColor: .black,backgroundColor: Color(#colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1)), cornerRadius: 10)
                            .frame(height: 44)

                            GradientButton(title: "Subscribe to Newsletter") {
                                settingsManager.subscribeToNewsletter()
                            }
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
                            SettingOptionRow(title: "Restore Purchases", icon: "Restore Purchases Icon", action: {
                                print("Restore Purchases tapped")
                            })
                            SettingOptionRow(title: "Rate App", icon: "Star Icon", action: {
                                print("Rate App tapped")
                            })
                            SettingOptionRow(title: "Share App", icon: "Share Icon", action: {
                                print("Share App tapped")
                            })
                        }

                        // Divider
                        DividerView()

                        // Support and Policy Links
                        VStack(spacing: 10) {
                            SettingOptionRow(title: "Email us", icon: "Email Icon", action: {
                                print("Email us tapped")
                            })
                            SettingOptionRow(title: "Privacy Policy", icon: "Privacy Icon", action: {
                                print("Privacy Policy tapped")
                            })
                            SettingOptionRow(title: "Terms of Use", icon: "Terms Icon", action: {
                                print("Terms of Use tapped")
                            })
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
        // Alert for user feedback
        .alert(isPresented: $settingsManager.showAlert) {
            Alert(
                title: Text("Newsletter Subscription"),
                message: Text(settingsManager.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}


struct NewsletterCustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color = .gray
    var textColor: Color = .black
    var backgroundColor: Color = Color(#colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1))
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Show the placeholder when text is empty
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.leading, 8) // Align placeholder text with text field's padding
            }
            
            // Actual TextField with clear background, so the placeholder shows
            TextField("", text: $text)
                .foregroundColor(textColor)
                .padding(10)
                .background(Color.clear)  // Make background clear so placeholder shows
                .cornerRadius(cornerRadius)
                .autocorrectionDisabled()
        }
        .background(backgroundColor) // Apply the actual background color here
        .cornerRadius(cornerRadius)
    }
}

