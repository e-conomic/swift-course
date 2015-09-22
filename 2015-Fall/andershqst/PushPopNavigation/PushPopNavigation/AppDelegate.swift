//
//  AppDelegate.swift
//  PushPopNavigation
//
//  Created by Anders Høst Kjærgaard on 22/09/2015.
//  Copyright © 2015 e-conomic International A/S. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let nav = UINavigationController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        nav.pushViewController(ViewController1(), animated: false)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

