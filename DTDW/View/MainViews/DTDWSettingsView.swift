//
//  SettingsView.swift
//  DTDW
//
//  Created by Sopnil Sohan on 7/11/24.
//

import SwiftUI
import MessageUI
import StoreKit

struct DTDWSettingsView: View {
    @StateObject private var firebaseViewModel = FirebaseViewModel()
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var purchaseViewModel = PurchaseViewModel.shared
    @State private var showUpgradePremiumSheet: Bool = false
    
    var placeholder: String = "Your email address"
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Settings")
                    .foregroundStyle(.black)
                    .font(.system(size: 26, weight: .bold))
                
                DividerView()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        //MARK: Premium Version Section
                        if !purchaseViewModel.isSubscribed {
                            SectionTitleView(title: "Premium Version")
                            
                            PremiumInfoView()

                            //MARK: View Plan Button
                            GradientButton(title: "View Plan") {
                                firebaseViewModel.showPremiumSubscriptions = true
                            }
                            
                            DividerView()
                            
                            //MARK: Upgrade Premium Section
                            SettingOptionRow(title: "Upgrade Premium", icon: "Premium Icon", action: {
                                showUpgradePremiumSheet = true
                            })
                            .padding(.top, 15)
                        }
                        
                        //MARK: Email Input and Newsletter Subscription
                        VStack(spacing: 20) {
                            Text("Receive Updates From The Landlady")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.black)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)

                            GradientButton(title: "Subscribe to Newsletter") {
                                settingsViewModel.showingSafariViewForNewsletter = true
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(radius: 4)
                        .padding(.top, PurchaseViewModel.shared.isSubscribed ? 0 : 15)
                        
                        DividerView()

                        //MARK: Additional Options
                        VStack(spacing: 10) {
                            SettingOptionRow(title: "Restore Purchases", icon: "Restore Purchases Icon", action: {
                                print("Restore Purchases tapped")
                                purchaseViewModel.confirmRestorePurchas()
                            })
                            SettingOptionRow(title: "Rate App", icon: "Star Icon", action: {
                                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                    SKStoreReviewController.requestReview(in: scene)
                                }
                            })
                            SettingOptionRow(title: "Share App", icon: "Share Icon", action: {
                                settingsViewModel.isShowingShareSheet = true
                            })
                        }
                        
                        DividerView()

                        //MARK: Support and Policy Links
                        VStack(spacing: 10) {
                            SettingOptionRow(title: "Email us", icon: "Email Icon", action: {
                                if MFMailComposeViewController.canSendMail() {
                                    settingsViewModel.isShowingMailView = true
                                } else {
                                    settingsViewModel.mailError = true
                                }
                            })
                            SettingOptionRow(title: "Privacy Policy", icon: "Privacy Icon", action: {
                                settingsViewModel.showingSafariViewForPrivacy = true
                            })
                            SettingOptionRow(title: "Terms of Use", icon: "Terms Icon", action: {
                                settingsViewModel.showingSafariViewForPrivacy = true
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
        .animation(.easeInOut, value: purchaseViewModel.showMessage)
        .alert(isPresented: $purchaseViewModel.showAlert) {
            Alert(
                title: Text("Restore Purchases"),
                message: Text(purchaseViewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $firebaseViewModel.showAlert) {
            Alert(
                title: Text("Newsletter Subscription"),
                message: Text(firebaseViewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $settingsViewModel.mailError) {
            Alert(
                title: Text("Mail Error"),
                message: Text("Your device is not configured to send emails."),
                dismissButton: .default(Text("OK"))
            )
        }
        .fullScreenCover(isPresented: $firebaseViewModel.showPremiumSubscriptions) {
            DTDWPremiumSubscriptionsView()
        }
        .fullScreenCover(isPresented: $showUpgradePremiumSheet) {
            DTDWPremiumSubscriptionsView()
        }
        .sheet(isPresented: $settingsViewModel.isShowingShareSheet) {
            DTDWShareSheetView(activityItems: ["Check out this amazing app: [DTDW: Real Estate analysis tool]! Download it here: https://apps.apple.com/app/6741393499"])
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
        }
        
        .sheet(isPresented: $settingsViewModel.isShowingMailView) {
            DTDWMailView(recipients: ["askthelandlady@gmail.com"], subject: "Support Request")
        }
        .fullScreenCover(isPresented: $settingsViewModel.showingSafariViewForNewsletter) {
            DTDWSafariView(url: settingsViewModel.newsletterURL)
        }
        .fullScreenCover(isPresented: $settingsViewModel.showingSafariViewForPrivacy) {
            DTDWSafariView(url: settingsViewModel.privacyURL)
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $settingsViewModel.showingSafariViewForTerms) {
            DTDWSafariView(url: settingsViewModel.termsURL)
                .ignoresSafeArea()
        }
    }
}
