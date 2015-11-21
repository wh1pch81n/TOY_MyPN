//
//  AppDelegate.swift
//  MyPN
//
//  Created by Derrick  Ho on 11/7/15.
//  Copyright © 2015 Derrick  Ho. All rights reserved.
//

import UIKit
import Parse

protocol MyPNProtocol {
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject])
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError)
}

enum MyPNStateMachine {
    case NotificationsDisabledInIOSSettings
    
}

public
class MyPN {
    static let sharedInstance: MyPN = MyPN()
    
    /**
    - You get the generated deviceToken from application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken: NSData)
    - Device tokens will be generated whenever MyPN::registerForPn() is called as long as at least one of the following is enabled in iOS Settings: "Show in Notification Center", "Sounds", "Badge App Icon", "Show on Lock Screen"
    - Device tokens will be generated when app goes to foreground as long as the app's iOS Notifications settings ("Show in Notification Center", "Sounds", "Badge App Icon", "Show on Lock Screen") go from an off state to an on state
    */
    static var deviceToken: NSData! // NEEDS to be SET before USE
    
    init() {
    }
    
    static func deviceTokenAsString() -> String {
        let devChar = MyPN.deviceToken.description.characters
        return Array(devChar)[1..<(devChar.count - 1)].map({ String($0)}).reduce("", combine: { $0 + $1 })
    }
    
    /**
    This will cause application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken: NSData) to be called.
    */
    static public func registerForPn() {
        UIApplication.sharedApplication()
            .registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: [
                        UIUserNotificationType.Badge,
                        UIUserNotificationType.Sound,
                        UIUserNotificationType.Alert
                    ],
                    categories: nil
                )
        )
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }

    /**
    Unregistering does not seem to effect the ios notifications settings.  However, unregistering makes the device identifiers stop comming in.  Unregistering is like sealing the mailbox of your app.  THe mail man( notification center) can still come but won't be able to put anything in.  THEREFORE NOT UNREGISTER!
    */
    static public func unregisterForPn() {
//        UIApplication.sharedApplication().unregisterForRemoteNotifications()
    }
    
    /**
    Shows Alerts that are currently enabled
    */
    static func enabledUserNotificationsAsArray() -> [String] {
        let b = UIApplication.sharedApplication().currentUserNotificationSettings()
        var arr: [String] = []
        let bb = b!.types.rawValue
        if bb & UIUserNotificationType.Alert.rawValue != 0 {
            arr += ["Alert"]
        }
        if bb & UIUserNotificationType.Badge.rawValue != 0 {
            arr += ["Badge"]
        }
        if bb & UIUserNotificationType.Sound.rawValue != 0 {
            arr += ["Sound"]
        }
        return arr
    }

}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MyPNProtocol {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        Parse.setApplicationId("vY2qwKErWmbSVtLjVEHjbpOkOEu5wnUcHvD5wZBC",
//            clientKey: "SEaPnsEVGmH3YJqLh8XHmwB4h0MpjRusvNA85NnM")
//        
//        // Register for Push Notitications
//        if application.applicationState != UIApplicationState.Background {
//            // Track an app open here if we launch with a push, unless
//            // "content_available" was used to trigger a background push (introduced in iOS 7).
//            // In that case, we skip tracking here to avoid double counting the app-open.
//            
//            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
//            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
//            var pushPayload = false
//            if let options = launchOptions {
//                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
//            }
//            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
//                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
//            }
//        }
        
        MyPN.registerForPn()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - sdfasdfasd
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
        
//        PFPush.handlePush(userInfo)
//        if application.applicationState == UIApplicationState.Inactive {
//            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
//        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
//        if error.code == 3010 {
//            print("Push notifications are not supported in the iOS Simulator.")
//        } else {
//            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
//        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
//        let installation = PFInstallation.currentInstallation()
//        installation.setDeviceTokenFromData(deviceToken)
//        installation.channels = ["global"]
//        installation.saveInBackground()
        
        /////
        
        
        MyPN.deviceToken = deviceToken
        print(MyPN.deviceTokenAsString())
//        print(deviceToken)
//       let s = Array(deviceToken.description.characters)[1..<(deviceToken.description.characters.count - 1)].map({ String($0)}).reduce("", combine: { $0 + $1 })
//        print(s)
    }
    

}

