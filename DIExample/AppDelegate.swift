//
//  AppDelegate.swift
//  DIExample
//
//  Created by Martin Mitrevski on 13.02.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DIService.injectDependencies()
        return true
    }
    
}

