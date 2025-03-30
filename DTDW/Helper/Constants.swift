//
//  Constants.swift
//  DTDW
//
//  Created by Sazza on 13/3/25.
//

import Foundation

// Constants for app
class Constants {
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
    static let bookAdTitle = "Don't forget to check out our books on Amazon!"
    static let books: [BooksModel] = [
        BooksModel(imageName: "Book1", title: "Q&A with Ask the Landlady", url:URL(string:"https://www.amazon.com/Ask-Landlady-Questions-Maintaining-Properties-ebook/dp/B0DJN314HD?ref_=ast_author_dp")!),
        BooksModel(imageName: "Book2", title: "Lessons from the Landlady", url:URL(string:"https://www.amazon.com/Lessons-Landlady-Mistakes-Successful-Estate/dp/B0CGZ2S4XP/ref=sr_1_1?crid=9W5VGZCYZ2V0&keywords=lessons+from+the+landlady&qid=1694719547&sprefix=lessons+from+the+landlady%2Caps%2C161&sr=8-1")!),
    ]
}
