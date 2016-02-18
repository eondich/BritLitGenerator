//
//  AddDataViewController.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 1/12/16.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//

import UIKit

class AddDataViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, ChooseTypeControllerDelegate {
    // To do: Add a "back" button that goes back to the table of story piece types
    //      - Make more aesthetically pleasing
    //      - Possibly make save() more efficient
    var mainText: UITextView!
    var titleText: UIButton!
    var complete: UIButton!
    var tempStory: StoryBits!
    var newText: String!
    var typeNo: Int!
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Add story bits"
        
        // Making sure that newText and typeNo have values-- at this point, every time I create an AddDataViewController I assign values to them, but I don't want to risk them being nil
        if newText == nil {
            newText = "No data"
        }
        
        if typeNo == nil {
            typeNo = 0
        }
        
        // Set view defaults
        let backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        let buttonColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        let textColor = UIColor(red: 0.5, green: 0.3, blue: 0.6, alpha: 1.0)
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
        //self.mainText.delegate = self
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
        let storyURL = documentsURL.URLByAppendingPathComponent("story.plist")
        if let data = NSData(contentsOfURL:storyURL) {
            tempStory = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? StoryBits
        }
        else {
            tempStory = StoryBits()
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
    
    // Executed when the cancel button is tapped- takes the user back to the main screen
    func cancelQuit() {
        let vc:NoStoryboardViewController = NoStoryboardViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK: Other methods
    // Sets the text in the title box
    func setText() {
        switch typeNo {
        case 1:
            self.titleText.setTitle("For example: (Your entry) Prince of Denmark", forState: .Normal)
        case 2:
            self.titleText.setTitle("For example: Harry Potter and the (Your Entry)", forState: .Normal)
        case 6:
            self.titleText.setTitle("Where does this story take place?  Once upon a time...", forState: .Normal)
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
        switch self.typeNo {
        case 1:
            if tempStory.titlePt1[0] == "[TITLE1]" {
                tempStory.titlePt1[0] = mainText.text
            }
            else {
                tempStory.titlePt1.append(mainText.text)
            }
        case 2:
            if tempStory.titlePt2[0] == "[TITLE2]" {
                tempStory.titlePt2[0] = mainText.text
            }
            else {
                tempStory.titlePt2.append(mainText.text)
            }
        case 3:
            if tempStory.authors[0] == "[AUTHORS]" {
                tempStory.authors[0] = mainText.text
            }
            else {
                tempStory.authors.append(mainText.text)
            }
        case 4:
            if tempStory.style1[0] == "[STYLE1]" {
                tempStory.style1[0] = mainText.text
            }
            else {
                tempStory.style1.append(mainText.text)
            }
        case 5:
            if tempStory.style2[0] == "[STYLE2]" {
                tempStory.style2[0] = mainText.text
            }
            else {
                tempStory.style2.append(mainText.text)
            }
        case 6:
            if tempStory.settings[0] == "[SETTINGS]" {
                tempStory.settings[0] = mainText.text
            }
            else {
                tempStory.settings.append(mainText.text)
            }
        case 7:
            if tempStory.heroPt1[0] == "[HERO1]" {
                tempStory.heroPt1[0] = mainText.text
            }
            else {
                tempStory.heroPt1.append(mainText.text)
            }
        case 8:
            if tempStory.heroPt2[0] == "[HERO2]" {
                tempStory.heroPt2[0] = mainText.text
            }
            else {
                tempStory.heroPt2.append(mainText.text)
            }
        case 9:
            if tempStory.companionPt1[0] == "[COMP1]" {
                tempStory.companionPt1[0] = mainText.text
            }
            else {
                tempStory.companionPt1.append(mainText.text)
            }
        case 10:
            if tempStory.companionPt2[0] == "[COMP2]" {
                tempStory.companionPt2[0] = mainText.text
            }
            else {
                tempStory.companionPt2.append(mainText.text)
            }
        case 11:
            if tempStory.villainsPt1[0] == "[VILL1]" {
                tempStory.villainsPt1[0] = mainText.text
            }
            else {
                tempStory.villainsPt1.append(mainText.text)
            }
        case 12:
            if tempStory.villainsPt2[0] == "[VILL2]" {
                tempStory.villainsPt2[0] = mainText.text
            }
            else {
                tempStory.villainsPt2.append(mainText.text)
            }
        case 13:
            if tempStory.conflicts[0] == "[CONFLICT]" {
                tempStory.conflicts[0] = mainText.text
            }
            else {
                tempStory.conflicts.append(mainText.text)
            }
        case 14:
            if tempStory.dramas[0] == "[DRAMA]" {
                tempStory.dramas[0] = mainText.text
            }
            else {
                tempStory.dramas.append(mainText.text)
            }
        case 15:
            if tempStory.conclusions[0] == "[CONCLUSION]" {
                tempStory.conclusions[0] = mainText.text
            }
            else {
                tempStory.conclusions.append(mainText.text)
            }
        default:
            typeNo = 0
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveStory(tempStory)
        
    }
    
}
