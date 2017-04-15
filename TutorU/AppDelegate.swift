//
//  AppDelegate.swift
//  TutorU
//
//  Created by Nick McDonald on 2/28/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static private let herokuClientKeyPlistIdentifier: String = "HerokuClientKey"
    lazy private var shouldShowFirstTimeLaunch: Bool = { [unowned self] in
        var returnVal = false
        let plistManager = PlistManager()
        do {
            if let readAppVersion = try plistManager.valueForKey("CFBundleShortVersionString", fromPlistFilename: "Info") as? String {
                appVersion = readAppVersion
                if self.isPreRelease(bundleVersion: appVersion) {
                    appIsAlphaOrBeta = true
                    returnVal = true
                }
            }
        } catch {
            fatalError("Error retrieving CFBundleShortVersionString")
        }
        return returnVal
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize Parse
        Parse.initialize(with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) in
            configuration.applicationId = "TutorU"
            configuration.server = "https://tutoruu.herokuapp.com/parse"
            
            // Use the PlistManager class to retrieve the client key.
            // This can be useful in the future if we want to hide the client key in commits.
            let plistManager: PlistManager = PlistManager()
            do {
                if let clientKey = try plistManager.valueForKey(AppDelegate.herokuClientKeyPlistIdentifier, fromPlistFilename: appKeysPlistFilenameIdentifier) {
                    configuration.clientKey = clientKey as? String  // set to nil assuming you have not set clientKey
                }
            } catch {
                fatalError()
            }
        }))
        
        if User.currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loggedInViewController = storyboard.instantiateInitialViewController()
            window?.rootViewController = loggedInViewController
        }
        
        // Show a message to the user on their first launch.
        setUserDefaults()
        if shouldShowFirstTimeLaunch {
            showAlphaOrBetaAlert()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    // MARK: - Helper functions.
    
    private func setUserDefaults() {
        let prefs = UserDefaults.standard
        if (prefs.value(forKey: appFirstTimeLaunchIdentifier) == nil) {
            prefs.set(true, forKey: appFirstTimeLaunchIdentifier)
        }
    }
    
    private func showAlphaOrBetaAlert() {
        if (UserDefaults.standard.bool(forKey: appFirstTimeLaunchIdentifier)) {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Welcome to beta TutorU", message: "This is a pre-release version of the app. Expect bugs, misbehaviors, crashes, etc. Please send reports to the TutorU team!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction) in
                    alertController.dismiss(animated: true, completion: nil)
                    UserDefaults.standard.set(false, forKey: appFirstTimeLaunchIdentifier)
                })
                alertController.addAction(okAction)
                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func isPreRelease(bundleVersion: String) -> Bool {
        let characters = bundleVersion.characters
        return characters.first == "0"
    }
}
