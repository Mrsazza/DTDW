//
//  InterstitialAdsViewModel.swift
//  DTDW
//
//  Created by Sopnil Sohan on 12/2/25.
//

import Foundation
import GoogleMobileAds

class InterstitialAdsViewModel: NSObject, FullScreenContentDelegate, ObservableObject {
    
    // Properties
    @Published var interstitialAdLoaded: Bool = false
    private var interstitialAd: InterstitialAd?
    private var adCompletionHandler: (() -> Void)?  // Completion handler
    
    override init() {
        super.init()
        loadInterstitialAd() // Load an ad on init
    }
    
    // Load InterstitialAd
    func loadInterstitialAd() {
        print("🟠 Loading interstitial ad...")
        InterstitialAd.load(with: "ca-app-pub-2809860876199165/3996540622", request: Request()) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("🔴 Failed to load ad: \(error.localizedDescription)")
                self.interstitialAdLoaded = false
                // Retry after 5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.loadInterstitialAd()
                }
                return
            }
            print("🟢 Ad loaded successfully")
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
            self.interstitialAdLoaded = true
        }
    }
    
    // Display InterstitialAd with optional completion handler
    func displayInterstitialAd(completion: (() -> Void)? = nil) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            print("❌ Could not get rootViewController")
            completion?()
            return
        }
        
        // Ensure the view controller is not already presenting something
        if rootVC.presentedViewController != nil {
            print("⚠️ Root view controller is already presenting another view controller. Ad will not be shown.")
            completion?() // Continue download if ad cannot be shown
            return
        }
        
        if let ad = interstitialAd {
            self.adCompletionHandler = completion  // Store completion handler
            ad.present(from: rootVC)
            self.interstitialAdLoaded = false
        } else {
            print("🔵 Ad wasn't ready")
            self.interstitialAdLoaded = false
            loadInterstitialAd()  // Reload for future use
            completion?()  // Proceed with download if ad isn't available
        }
    }

    // Failure notification
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("🟡 Failed to display interstitial ad: \(error.localizedDescription)")
        loadInterstitialAd()  // Reload ad on failure
    }
    
    // Indicate notification
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("🤩 Displayed an interstitial ad")
        self.interstitialAdLoaded = false
    }
    
    // Close notification
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("😔 Interstitial ad closed")
        loadInterstitialAd()  // Reload for future use
        adCompletionHandler?() // Execute the stored completion handler
        adCompletionHandler = nil // Reset handler
    }
}
