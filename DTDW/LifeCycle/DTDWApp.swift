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
        // Initialize Firebase
        FirebaseApp.configure()
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


class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        Messaging.messaging().delegate = self
        
        // Initialize Google Mobile Ads SDK
        MobileAds.shared.start()

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
                if let error = error {
                    print("❌ Error requesting push notifications permission: \(error)")
                } else {
                    print("✅ Push notifications permission granted: \(granted)")
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        return true
    }

    // ✅ Correct implementation of APNs device token retrieval
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("✅ APNs Device Token: \(tokenString)")
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ Failed to register for remote notifications: \(error.localizedDescription)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("📩 Message ID: \(messageID)")
        }
        print("📩 Received Notification: \(userInfo)")
        completionHandler(.newData)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken = fcmToken {
            print("✅ FCM Device Token: \(fcmToken)")
        } else {
            print("❌ Failed to retrieve FCM token.")
        }
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("📩 Foreground Notification - Message ID: \(messageID)")
        }
        print("📩 Foreground Notification: \(userInfo)")
        completionHandler([.banner, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("📩 Background Notification - Message ID: \(messageID)")
        }
        print("📩 Background Notification: \(userInfo)")
        completionHandler()
    }
}

