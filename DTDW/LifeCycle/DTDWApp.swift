//
//  DTDWApp.swift
//  DTDW
//
//  Created by Sazza on 5/11/24.
//

import SwiftUI
import Firebase
import SwiftData
import GoogleMobileAds
import UserNotifications

@main
struct DTDWApp: App {
    @StateObject var interstitialAdsViewModel = InterstitialAdsViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PropertyDataModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        FirebaseApp.configure() // Initialize Firebase
    }
    
    var body: some Scene {
        WindowGroup {
            DTDWTabView()
                .dynamicTypeSize(.medium)
                .modelContainer(sharedModelContainer)
                .environmentObject(interstitialAdsViewModel)
                .onAppear {
                    interstitialAdsViewModel.loadInterstitialAd()
                }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Google Mobile Ads SDK
        MobileAds.shared.start()

        // Set up push notifications
        setupPushNotifications(application)

        // Set Firebase Messaging delegate
        Messaging.messaging().delegate = self
        
        return true
    }

    // Called when the app successfully registers for remote notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("Successfully registered for remote notifications with token: \(deviceToken)")
    }

    // Called when the app fails to register for remote notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }

    // Push Notification Setup
    func setupPushNotifications(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
                print("Push notifications permission granted.")
            } else if let error = error {
                print("Push notifications permission denied: \(error.localizedDescription)")
            }
        }
    }

    // Handle incoming push notifications (when app is in the foreground)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Use the updated notification presentation options for iOS 14.0 and later
        completionHandler([.banner, .sound, .badge])
    }

    // Handle notification taps (when app is in the background)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Received notification with user info: \(userInfo)")
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    // Handle the Firebase Messaging token refresh
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        // Optionally, send token to your server for further processing
    }
}
