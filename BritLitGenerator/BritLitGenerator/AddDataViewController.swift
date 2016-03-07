//
//  AddDataViewController.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 1/12/16.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//
// In this view controller, the user adds text to the lists that are used to generate random stories

import UIKit

class AddDataViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, ChooseTypeControllerDelegate {
    // To do: Make more aesthetically pleasing
    var mainText: UITextView!
    var titleText: UIButton!
    var complete: UIButton!
    var story: StoryBits!
    var newText: String!
    var typeNo: Int!
    var storyLabels: [String]!
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Make your own story"
        
        // Making sure that newText and typeNo have values-- at this point, every time I create an AddDataViewController I assign values to them, but I don't want to risk them being nil
        if newText == nil {
            newText = "For example: (Your entry) Prince of Denmark"
        }
        
        if typeNo == nil {
            typeNo = 0
        }
        
        self.story = StoryBits()
        
        self.storyLabels = ["title1", "title2", "author", "style1", "style2", "setting", "hero1", "hero2", "comp1", "comp2", "vill1", "vill2", "conflict", "drama", "conclusion"]
        
        // Set view defaults
        let backgroundColor = UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1.0)
        let buttonColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        let textColor = UIColor(red: 0.75, green: 0.31, blue: 0.52, alpha: 1.0)// red: 0.4, green: 0.75, blue: 0.55, alpha: 1.0)
        let borderColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        self.view.backgroundColor = backgroundColor
        let font = UIFont.systemFontOfSize(14.0)
        
        // Build the main text box where new data options are entered
        self.mainText = UITextView()
        self.mainText.translatesAutoresizingMaskIntoConstraints = false
        self.mainText.backgroundColor = UIColor.whiteColor()
        self.mainText.font = font
        self.mainText.textColor = textColor
        self.mainText.layer.borderColor = borderColor.CGColor
        self.mainText.layer.borderWidth = 1
        self.mainText.autocapitalizationType = .None
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(mainText)
        
        // Add a title to the page so the user knows what type of phrase they're adding to the system.  Mostly this can just be newText, but a couple of them need a bit more context so the user gets the grammar right
        self.titleText = UIButton()
        self.titleText.translatesAutoresizingMaskIntoConstraints = false
        self.titleText.backgroundColor = buttonColor
        self.titleText.setTitleColor(textColor, forState: .Normal)
        self.titleText.layer.borderColor = borderColor.CGColor
        self.titleText.layer.borderWidth = 1
        self.titleText.layer.cornerRadius = 8
        self.titleText.layer.shadowColor = UIColor.blackColor().CGColor
        self.titleText.layer.shadowOffset = CGSizeMake(5, 5)
        self.titleText.layer.shadowRadius = 5
        self.titleText.addTarget(self, action: "getOps:", forControlEvents: .TouchUpInside)
        self.titleText.sizeToFit()
        self.setText()
        self.view.addSubview(titleText)
        
        // Create a save button
        self.complete = UIButton()
        self.complete.translatesAutoresizingMaskIntoConstraints = false
        self.complete.backgroundColor = buttonColor
        self.complete.setTitleColor(textColor, forState: .Normal)
        self.complete.layer.borderColor = borderColor.CGColor
        self.complete.layer.borderWidth = 1
        self.complete.layer.cornerRadius = 8
        self.complete.setTitle("Save", forState: UIControlState.Normal)
        self.complete.addTarget(self, action: "saveQuit", forControlEvents: .TouchUpInside)
        self.view.addSubview(complete)
        
        // Setting up the views/constraints
        let views: [String:AnyObject] = ["main": mainText,
            "title": titleText,
            "save": complete,
            "topLayoutGuide": self.topLayoutGuide,
            "bottomLayoutGuide": self.bottomLayoutGuide]
        
        let metrics: [String:Float] = ["mainMargin": 20,
            "mainHeight": 300,
            "titleMargin": 20,
            "titleHeight": 30,
            "saveWidth": 50,
            "cancelWidth": 70,
            "buttonMargin": 30,
            "buttonGap": 10]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-mainMargin-[main]-mainMargin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-titleMargin-[title]-titleMargin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[save(saveWidth)]-buttonMargin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-mainMargin-[title(titleHeight)]-mainMargin-[main(mainHeight)]-mainMargin-[save]", options: [], metrics: metrics, views: views))
        
        // Load the story content options so they can be added to later
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        var storyURL = documentsURL.URLByAppendingPathComponent("story.plist")
        if let dictionary = NSMutableDictionary(contentsOfURL: storyURL) {
            self.story.dict = dictionary
        }
        else {
            storyURL = NSBundle.mainBundle().URLForResource("story", withExtension: "plist")!
            if let dictionary = NSMutableDictionary(contentsOfURL: storyURL) {
                self.story.dict = dictionary
            }
        }
        
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if complete == sender {
    
    }
    }*/
    
    // MARK: Button handling
    // Executed when the save button is tapped
    func saveQuit() {
        if mainText.text != nil {
            save()
        }
        mainText.text = ""
    }
    
    // Calls a popover
    func getOps(sender: UIButton!) {
        let vc = ChooseAddTypeViewController()
        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        let presentationController = vc.popoverPresentationController
        presentationController?.delegate = self
        presentationController?.permittedArrowDirections = .Any
        presentationController?.sourceView = sender
        presentationController?.sourceRect = sender.bounds
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // Makes the popover behave like a popover and not a separate view on iPhone
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    // Defunct but here for future reference
//    func cancelQuit() {
//        let vc:NoStoryboardViewController = NoStoryboardViewController()
//        self.presentViewController(vc, animated: true, completion: nil)
//    }
    
    // MARK: Other methods
    // Sets the text in the title box
    func setText() {
        switch typeNo {
        case 0:
            self.titleText.setTitle("For example: (Your entry) Prince of Denmark", forState: .Normal)
        case 1:
            self.titleText.setTitle("For example: Harry Potter and the (Your Entry)", forState: .Normal)
        case 5:
            self.titleText.setTitle("Where does this story take place?", forState: .Normal)
        case 6:
            self.titleText.setTitle("Who/what is your hero?", forState: .Normal)
        case 8:
            self.titleText.setTitle("Who/what is your sidekick?", forState: .Normal)
        case 10:
            self.titleText.setTitle("Who/what is your villain?", forState: .Normal)
        default:
            self.titleText.setTitle(newText, forState: .Normal)
        }
    }
    
    // Added to conform to the ChooseTypeDelegate protocol.  Performed when a cell in the popover view is selected
    func typeWasSelected(newTypeNo: Int, newTypeText: String) {
        self.typeNo = newTypeNo
        self.newText = newTypeText
        setText()
    }
    
    // Saves the text the user has entered to the appropriate list depending on the story piece selected
    // Either the default entry is overwritten or the text is appended to the list
    // I have some ideas for making this more compact, I just haven't messed around with it yet.
    func save() {
        let nullOps = ["[TITLE1]", "[TITLE2]", "[AUTHORS]", "[STYLE1]", "[STYLE2]", "[SETTINGS]", "[HERO1]", "[HERO2]", "[COMP1]", "[COMP2]", "[VILL1]", "[VILL2]", "[CONFLICT]", "[DRAMA]", "[CONCLUSION]"]
        var curList = self.story.dict.valueForKeyPath(self.storyLabels[self.typeNo]) as! [String]
        if nullOps.contains(curList[0]) {
            curList[0] = mainText.text
        }
        else {
            curList.append(mainText.text)
        }
        self.story.dict.setValue(curList, forKey: self.storyLabels[self.typeNo])
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveStory(story)
        
    }
    
}
