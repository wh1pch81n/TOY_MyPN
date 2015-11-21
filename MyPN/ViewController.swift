//
//  ViewController.swift
//  MyPN
//
//  Created by Derrick  Ho on 11/7/15.
//  Copyright © 2015 Derrick  Ho. All rights reserved.
//

import UIKit

public var deviceToken:String = ""

public func registerForPn() {
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

class ViewController: UIViewController {

    lazy var regPn: UIButton = {
        let b = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        b.setTitle("regPn", forState: UIControlState.Normal)
        b.addTarget(self, action: "pressedRegisterPN:", forControlEvents: UIControlEvents.TouchUpInside)
        return b
    }()
    
    lazy var unregPn: UIButton = {
        let b = UIButton(frame: CGRect(x: 150, y: 50, width: 100, height: 100))
        b.setTitle("unregPn", forState: UIControlState.Normal)
        b.addTarget(self, action: "pressedUnregisterPN:", forControlEvents: UIControlEvents.TouchUpInside)
        return b
        }()
    
    lazy var isRegForRemoteLabel: UILabel = {
       let l = UILabel(frame: CGRect(x: 50, y: 150, width: 100, height: 100))
        l.textColor = UIColor.whiteColor()
        return l
    }()
    
    lazy var refreshIsRegButton: UIButton = {
        let b = UIButton(frame: CGRect(x: 150, y: 150, width: 200, height: 100))
        b.setTitle("refreshIsRegButton", forState: UIControlState.Normal)
        b.addTarget(self, action: "pressedIsRegistered:", forControlEvents: UIControlEvents.TouchUpInside)
        return b
        }()
    
    lazy var deviceTokenLabel: UILabel = {
        let l = UILabel(frame: CGRect(x: 50, y: 250, width: 100, height: 100))
        l.textColor = UIColor.whiteColor()
        return l
        }()
    
    lazy var refreshDeviceToken: UIButton = {
        let b = UIButton(frame: CGRect(x: 150, y: 250, width: 200, height: 100))
        b.setTitle("refreshDeviceToken", forState: UIControlState.Normal)
        b.addTarget(self, action: "pressedRefeshDeviceToken:", forControlEvents: UIControlEvents.TouchUpInside)
        return b
        }()
    
    override func loadView() {
        self.view = UIView()
        self.view.addSubview(regPn)
        self.view.addSubview(unregPn)
        self.view.addSubview(isRegForRemoteLabel)
        self.view.addSubview(refreshIsRegButton)
        self.view.addSubview(deviceTokenLabel)
        self.view.addSubview(refreshDeviceToken)
    }
    
    
    func pressedRegisterPN(sender: AnyObject) {
       MyPN.registerForPn()
    }
    
    func pressedUnregisterPN(sender: AnyObject) {
        MyPN.unregisterForPn()
    }
    
    func pressedIsRegistered(sender: AnyObject) {
        self.isRegForRemoteLabel.text = MyPN.enabledUserNotificationsAsArray().count > 0 ? "YES" : "NO"
    }
    
    func pressedRefeshDeviceToken(sender: AnyObject) {
        deviceTokenLabel.text = deviceToken
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

