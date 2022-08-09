//
//  AppDelegate.swift
//  RIBsTest
//
//  Created by Egor Malyshev on 08.08.2022.
//

import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent(webService: WebService())).build()
        self.launchRouter = launchRouter
        launchRouter.launchFromWindow(window)
        
        return true
    }

}

