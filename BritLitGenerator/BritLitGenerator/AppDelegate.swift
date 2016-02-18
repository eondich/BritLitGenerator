//
//  AppDelegate.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 12/30/15.
//  Copyright © 2015 Elena Ondich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // To do: Deal with circumstances where user leaves app
    
    var window: UIWindow?
    var testStory: StoryBits?
    
    var noStoryboardViewController: NoStoryboardViewController?
    var addDataViewController: AddDataViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        //        Load data about stories that have already been created.  Used for testing
        //        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        //        let storyURL = documentsURL.URLByAppendingPathComponent("story.plist")
        //        if let data = NSData(contentsOfURL:storyURL) {
        //            testStory = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? StoryBits
        //        }
        
        // Trying to set up tab bar root view controller
        
        self.noStoryboardViewController = NoStoryboardViewController()
        let mainNavigationController = UINavigationController(rootViewController: self.noStoryboardViewController!)
        mainNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .Downloads, tag: 0)
        
        self.addDataViewController = AddDataViewController()
        self.addDataViewController?.typeNo = 1
        let addNavigationController = UINavigationController(rootViewController: self.addDataViewController!)
        addNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .Contacts, tag: 0)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainNavigationController, addNavigationController]
        
        let startupViewController = tabBarController
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startupViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
    
    func saveStory(story: StoryBits) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(story)
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let storyURL = documentsURL.URLByAppendingPathComponent("story.plist")
        
        data.writeToURL(storyURL, atomically: true)
    }
    
    
}

