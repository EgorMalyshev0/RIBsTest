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
    private var urlHandler: URLHandler?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let result = RootBuilder(dependency: AppComponent(webService: WebService())).build()
        launchRouter = result.router
        urlHandler = result.urlHandler
        launchRouter?.launchFromWindow(window)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        urlHandler?.handle(url)
        return true
    }

}

