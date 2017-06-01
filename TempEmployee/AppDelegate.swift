//
//  AppDelegate.swift
//  Temp Provide
//
//  Created by kashif Saeed on 02/05/2017.
//  Copyright © 2017 Attribe. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FacebookCore
import SwiftyUserDefaults
import AWSCore


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController : UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        IQKeyboardManager.sharedManager().enable = true
        AWSDDLog.sharedInstance.logLevel = .verbose
        
        //        let storyboard = UIStoryboard.storyboard(.registration)
        //
        //        let rootController : ProfilePicViewController  = storyboard.instantiateViewController()
        //
        //
        //        self.setRootController(root: rootController)
        
        
        
        let credentialProvider = AWSStaticCredentialsProvider(accessKey:Constants.S3Credentials.accessKey , secretKey:Constants.S3Credentials.secretkey )
        let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        setRootViewController()
        
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
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return SDKApplicationDelegate.shared.application(application, open:url, sourceApplication:sourceApplication, annotation:annotation)
    }
    
    func setRootViewController(){
        
        
        
        // Job seeker not registeres set show case as root view controller
        if !Defaults[.hasUserRegistered] {
            
            // get your storyboard
            let storyboard = UIStoryboard(name: "ShowCase", bundle: nil)
            
            // instantiate your desired ViewController
            let rootController : MainViewController  = storyboard.instantiateViewController(withIdentifier: "ShowCaseController") as! MainViewController
            
            self.setRootController(root: rootController)
            
            
        }
            
            // Job seeker regsitered but licence detail not uploaded take him to licenceContainerController
        else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // instantiate your desired ViewController
            let rootController : UITabBarController  = storyboard.instantiateViewController(withIdentifier: "TabViewController") as! UITabBarController
            self.window?.rootViewController = rootController
            
        }
        
    }
    
    func setRootController(root controller : UIViewController) {
        
        navigationController  =  self.window?.rootViewController as? UINavigationController
        
        navigationController?.setViewControllers([controller], animated: false)
    }
}

