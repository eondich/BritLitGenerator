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
    
    var noStoryboardViewController: NoStoryboardViewController?
    var addDataViewController: AddDataViewController?
    var deleteViewController: DeleteViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Set up view controllers that will appear in tabs
        
        // Main view controller where random stories are generated
        self.noStoryboardViewController = NoStoryboardViewController()
        let mainNavigationController = UINavigationController(rootViewController: self.noStoryboardViewController!)
        mainNavigationController.tabBarItem = UITabBarItem(title: "Get a story", image: UIImage(named: "dice"), tag: 0)
        
        // View controller for adding data
        self.addDataViewController = AddDataViewController()
        self.addDataViewController?.typeNo = 0
        let addNavigationController = UINavigationController(rootViewController: self.addDataViewController!)
        addNavigationController.tabBarItem = UITabBarItem(title: "Make a story", image: UIImage(named: "pen"), tag: 0)
        
        // View controller for deleting data
        self.deleteViewController = DeleteViewController()
        let deleteNavigationController = UINavigationController(rootViewController: self.deleteViewController!)
        deleteNavigationController.tabBarItem = UITabBarItem(title: "Delete data", image: UIImage(named: "delete"), tag: 0)
        
        // Images from https://icons8.com/
        
        // Set up tab bar controller and set as default
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainNavigationController, addNavigationController, deleteNavigationController]
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

