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
//    @EnvironmentObject var firebaseViewModel : FirebaseViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var purchaseViewModel: PurchaseViewModel
    @State private var activeSheet: ActiveSheet?
    @State private var alertMessage: String?
    @State private var showAlert: Bool = false

    // Constants for strings
    private struct Constants {
        static let settingsTitle = "Settings"
        static let premiumVersionTitle = "Premium Version"
        static let viewPlanTitle = "View Plan"
        static let upgradePremiumTitle = "Upgrade Premium"
        static let receiveUpdatesTitle = "Receive updates from Ask The Landlady"
        static let subscribeToNewsletterTitle = "Subscribe to Newsletter"
        static let restorePurchasesTitle = "Restore Purchases"
        static let rateAppTitle = "Rate App"
        static let shareAppTitle = "Share App"
        static let emailUsTitle = "Email us"
        static let privacyPolicyTitle = "Privacy Policy"
        static let termsOfUseTitle = "Terms of Use"
        static let mailErrorMessage = "Your device is not configured to send emails."
    }

    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Title
                Text(Constants.settingsTitle)
                    .foregroundStyle(.black)
                    .font(.system(size: 26, weight: .bold))
                
                DividerView()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        // MARK: Premium Version Section
                        if !purchaseViewModel.isSubscribed {
                            SectionTitleView(title: Constants.premiumVersionTitle)
                            
                            PremiumInfoView()

                            GradientButton(title: Constants.viewPlanTitle) {
                                activeSheet = .premiumSubscriptions
                            }
                            
                            DividerView()
                            
                            SettingsButton(title: Constants.upgradePremiumTitle, icon: .premium) {
                                activeSheet = .premiumSubscriptions
                            }
                            .padding(.top, 15)
                        }
                        
                        // MARK: Email Input and Newsletter Subscription
                        VStack(spacing: 20) {
                            Text(Constants.receiveUpdatesTitle)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.black)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)

                            GradientButton(title: Constants.subscribeToNewsletterTitle) {
                                activeSheet = .safariView(settingsViewModel.newsletterURL)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(radius: 4)
                        .padding(.top, purchaseViewModel.isSubscribed ? 0 : 15)
                        
                        DividerView()

                        // MARK: Additional Options
                        VStack(spacing: 10) {
                            SettingsButton(title: Constants.restorePurchasesTitle, icon: .restorePurchases) {
                                purchaseViewModel.confirmRestorePurchas()
                            }
                            SettingsButton(title: Constants.rateAppTitle, icon: .star) {
                                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                    SKStoreReviewController.requestReview(in: scene)
                                }
                            }
                            SettingsButton(title: Constants.shareAppTitle, icon: .share) {
                                activeSheet = .shareSheet
                            }
                        }
                        
                        DividerView()

                        // MARK: Support and Policy Links
                        VStack(spacing: 10) {
                            SettingsButton(title: Constants.emailUsTitle, icon: .email) {
                                if MFMailComposeViewController.canSendMail() {
                                    activeSheet = .mailView
                                } else {
                                    alertMessage = Constants.mailErrorMessage
                                    showAlert = true
                                }
                            }
                            SettingsButton(title: Constants.privacyPolicyTitle, icon: .privacy) {
                                activeSheet = .safariView(settingsViewModel.privacyURL)
                            }
                            SettingsButton(title: Constants.termsOfUseTitle, icon: .terms) {
                                activeSheet = .safariView(settingsViewModel.termsURL)
                            }
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert"),
                message: Text(alertMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
        .fullScreenCover(item: $activeSheet) { sheet in
            switch sheet {
            case .premiumSubscriptions:
                DTDWPremiumSubscriptionsView()
            case .shareSheet:
                DTDWShareSheetView(activityItems: ["Check out this amazing app: [DTDW: Real Estate analysis tool]! Download it here: https://apps.apple.com/app/6741393499"])
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
            case .mailView:
                DTDWMailView(recipients: ["askthelandlady@gmail.com"], subject: "Support Request")
            case .safariView(let url):
                DTDWSafariView(url: url)
                    .ignoresSafeArea()
            }
        }
    }
}

// MARK: - SettingOptionRow
struct SettingsButton: View {
    let title: String
    let icon: Icon
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(icon.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)

                Text(title)
                    .font(.system(size: 18))
                    .foregroundColor(.black)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(Color(#colorLiteral(red: 0.6821199059, green: 0.2117495537, blue: 0.475467205, alpha: 1)))
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Icon Enum
enum Icon: String {
    case premium = "Premium Icon"
    case restorePurchases = "Restore Purchases Icon"
    case star = "Star Icon"
    case share = "Share Icon"
    case email = "Email Icon"
    case privacy = "Privacy Icon"
    case terms = "Terms Icon"
}

// MARK: - ActiveSheet Enum
enum ActiveSheet: Identifiable {
    case premiumSubscriptions
    case shareSheet
    case mailView
    case safariView(URL)
    
    var id: String {
        switch self {
        case .premiumSubscriptions: return "premiumSubscriptions"
        case .shareSheet: return "shareSheet"
        case .mailView: return "mailView"
        case .safariView(let url): return "safariView-\(url.absoluteString)"
        }
    }
}

//// MARK: - Helper Extensions
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
