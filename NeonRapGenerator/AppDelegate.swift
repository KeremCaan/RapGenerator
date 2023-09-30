//
//  AppDelegate.swift
//  NeonRapGenerator
//
//  Created by Kerem Caan on 28.08.2023.
//

import UIKit
import NeonSDK
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Font.configureFonts(font: .Inter)
        Font.configureFonts(font: .Poppins)
        Neon.configure(
            window: &window,
            onboardingVC: Onboarding1VC(),
            paywallVC: PaywallVC(),
            homeVC: HomeVC())
        RevenueCatManager.configure(withAPIKey: "appl_WYuzpgEFSvSYYoIavXjsyQnTykV", products : [
            "com.neonapps.education.SwiftyStoreKitDemo.Weekly",
            "com.neonapps.education.SwiftyStoreKitDemo.Montly",
            "com.neonapps.education.SwiftyStoreKitDemo.Annual"
        ])
        return true
    }


}



