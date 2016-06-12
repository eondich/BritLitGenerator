//
//  AppDelegate.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 12/30/15.
//  Copyright © 2015 Elena Ondich. All rights reserved.
//

// TO DO:
// Clean up code- make variable names better, comment everything, make code more elegant where possible, delete extraneous stuff, etc
// Color scheme
// Word choice
// Built-in data

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // To do: Deal with circumstances where user leaves app
    
    var window: UIWindow?
    var testStory: StoryBits?
    
    var randomStoryViewController: RandomStoryViewController?
    var editViewController: EditViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Set up view controllers that will appear in tabs
        
        // Main view controller where random stories are generated
        self.randomStoryViewController = RandomStoryViewController()
        let mainNavigationController = UINavigationController(rootViewController: self.randomStoryViewController!)
        mainNavigationController.tabBarItem = UITabBarItem(title: "Get a story", image: UIImage(named: "dice"), tag: 0)
        
        // View controller for editing data
        self.editViewController = EditViewController()
        self.editViewController?.typeNo = 0
        let editNavigationController = UINavigationController(rootViewController: self.editViewController!)
        editNavigationController.tabBarItem = UITabBarItem(title: "Edit", image: UIImage(named: "pen"), tag: 0)
        
        
        // Images from https://icons8.com/
        
        // Set up tab bar controller and set as default
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainNavigationController, editNavigationController]
        tabBarController.tabBar.tintColor = UIColor(red: 0.8, green: 0.52, blue: 0.0, alpha: 1.0)
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
    
    // Saves story data to a plist
    func saveStory(story: StoryBits) {
        let data = story.dict
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let storyURL = documentsURL.URLByAppendingPathComponent("story.plist")
        
        data.writeToURL(storyURL, atomically: true)
        
    }
    
    
}

