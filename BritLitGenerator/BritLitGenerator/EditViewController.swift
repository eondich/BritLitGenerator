//
//  EditViewController.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 1/12/16.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//
// In this view controller, the user adds text to the lists that are used to generate random stories

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, ChooseTypeControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    // To do: Make more aesthetically pleasing
    var mainText: UITextView!
    var titleText: UIButton!
    var complete: UIButton!
    var story: StoryBits!
    var newText: String!
    var typeNo: Int!
    var storyLabels: [String]!
    // Imported from DeleteViewController
    var deleteOptions: [String]!
    var tableView: UITableView!
    var tableBackgroundColor: UIColor!
    // Added later
    var tableExp: UITextView!
    var toast: UILabel!
    var backgroundColor: UIColor!
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.story = StoryBits()
        
        // deleteOptions is the list of story pieces that can currently be deleted.
        loadData()
        self.deleteOptions = (self.story.dict.valueForKeyPath("title1") as? [String])!
        
        self.navigationItem.title = "Make your own story"
        
        // Making sure that newText and typeNo have values-- at this point, every time I create an EditViewController I assign values to them, but I don't want to risk them being nil
        if newText == nil {
            newText = "For example: (Your entry) Prince of Denmark"
        }
        
        if typeNo == nil {
            typeNo = 0
        }
        
        self.story = StoryBits()
        
        self.storyLabels = ["title1", "title2", "author", "style1", "style2", "setting", "hero1", "hero2", "comp1", "comp2", "vill1", "vill2", "conflict", "drama", "conclusion"]
        
//        self.navigationItem.title = "Your story"
//        self.view.backgroundColor = UIColor(red: 0.2, green: 0.33, blue: 0.0, alpha: 1.0)
//        self.font = UIFont.systemFontOfSize(14.0)
//        self.titleColor = UIColor(red: 0.8, green: 0.52, blue: 0.0, alpha: 1.0)
//        self.fontColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
//        self.backgroundColor = UIColor(red: 1.0, green: 0.97, blue: 0.9, alpha: 1.0)
//        let buttonColor = UIColor(red: 0.55, green: 0.2, blue: 0.0, alpha: 1.0)
//        self.titleFont = UIFont.systemFontOfSize(18.0)
        
        // Set view defaults
        backgroundColor = UIColor(red: 0.2, green: 0.33, blue: 0.0, alpha: 1.0)
        self.tableBackgroundColor = UIColor(red: 1.0, green: 0.97, blue: 0.9, alpha: 1.0)
        let buttonColor = UIColor(red: 0.55, green: 0.2, blue: 0.0, alpha: 1.0)
        let textColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        let borderColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        self.view.backgroundColor = backgroundColor
        let font = UIFont.systemFontOfSize(14.0)
        let smallFont = UIFont.systemFontOfSize(13.0)
        let expTextColor = UIColor(red: 0.8, green: 0.52, blue: 0.0, alpha: 1.0)
        
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
        self.titleText.backgroundColor = expTextColor
        self.titleText.setTitleColor(UIColor.whiteColor(), forState: .Normal)
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
        self.complete.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.complete.layer.borderColor = borderColor.CGColor
        self.complete.layer.borderWidth = 1
        self.complete.layer.cornerRadius = 8
        self.complete.setTitle("Save", forState: UIControlState.Normal)
        self.complete.addTarget(self, action: "saveQuit", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.complete)
        
        self.tableExp = UITextView()
        self.tableExp.translatesAutoresizingMaskIntoConstraints = false
        self.tableExp.backgroundColor = backgroundColor
        self.tableExp.font = smallFont
        self.tableExp.textColor = expTextColor
        self.tableExp.editable = false
        self.tableExp.text = "Current options"
        self.tableExp.textAlignment = .Left
        self.view.addSubview(self.tableExp)
        
        // Shows options of data to delete
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.frame = CGRectMake(0, 50, 320, 200)
        self.tableView.layer.borderWidth = 1
        self.tableView.layer.borderColor = borderColor.CGColor
        self.tableView.backgroundColor = backgroundColor
        self.view.addSubview(self.tableView)
        
        self.toast = UILabel()
        self.toast.frame = CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-100, 300, 35)
        self.toast.translatesAutoresizingMaskIntoConstraints = false
        self.toast.backgroundColor = backgroundColor
        self.toast.textColor = backgroundColor
        self.toast.text = "Save successful!"
        self.toast.textAlignment = .Right
        self.toast.clipsToBounds = true
        self.toast.font = smallFont
        self.view.addSubview(self.toast)
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Setting up the views/constraints
        let views: [String:AnyObject] = ["main": self.mainText,
            "title": self.titleText,
            "save": self.complete,
            "table": self.tableView,
            "exp": self.tableExp,
            "toast": self.toast,
            "topLayoutGuide": self.topLayoutGuide,
            "bottomLayoutGuide": self.bottomLayoutGuide]
        
        let metrics: [String:Float] = ["mainMargin": 20,
            "mainHeight": 47,
            "titleMargin": 20,
            "titleHeight": 30,
            "saveWidth": 50,
            "tableMargin": 7,
            "expMarginV": 7,
            "expMarginH":20,
            "expWidth": 160,
            "expHeight":23,
            "toastWidth": 140,
            "toastHeight": 23,
            "toastMarginH": 15,
            "toastMarginV": 10,
            "cancelWidth": 70,
            "buttonMargin": 30,
            "buttonGap": 10]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-mainMargin-[main]-mainMargin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-titleMargin-[title]-titleMargin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[table]-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[toast(toastWidth)]-toastMarginH-[save(saveWidth)]-buttonMargin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-expMarginH-[exp(expWidth)]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-mainMargin-[title(titleHeight)]-mainMargin-[main(mainHeight)]-tableMargin-[save]-tableMargin-[table]-[bottomLayoutGuide]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[exp(expHeight)]-expMarginV-[table]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[toast(toastHeight)]-toastMarginV-[table]", options: [], metrics: metrics, views: views))
        
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
    
    // MARK: Table management
    // The table has as many cells as story parts you can delete.  If deleteOptions is effectively empty (only contains debugging data), returns 0
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let nullOps = ["[TITLE1]", "[TITLE2]", "[AUTHORS]", "[STYLE1]", "[STYLE2]", "[SETTINGS]", "[HERO1]", "[HERO2]", "[COMP1]", "[COMP2]", "[VILL1]", "[VILL2]", "[CONFLICT]", "[DRAMA]", "[CONCLUSION]"]
        if nullOps.contains(self.deleteOptions[0]) {
            return 0
        }
        else {
            return self.deleteOptions.count
        }
    }
    
    // Fills table with data from deleteOptions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell!
        cell.textLabel?.text = self.deleteOptions[self.deleteOptions.count - indexPath.row - 1]
        cell.backgroundColor = self.tableBackgroundColor
        return cell
    }
    
    // If a row is selected, displays an alert.  If delete is selected, deletes the data displayed in the selected row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Hold on-", message: "Do you want to delete this story piece?", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: {action in self.deleteData(indexPath.row) } )
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: Deleting data
    // If the only item in deleteOptions is deleted, replaces it with default (debugging) data.  Otherwise, removes the item from deleteOptions and saves the change to the story file
    func deleteData(index: Int) {
        let nullOps = ["[TITLE1]", "[TITLE2]", "[AUTHORS]", "[STYLE1]", "[STYLE2]", "[SETTINGS]", "[HERO1]", "[HERO2]", "[COMP1]", "[COMP2]", "[VILL1]", "[VILL2]", "[CONFLICT]", "[DRAMA]", "[CONCLUSION]"]
        if (self.deleteOptions.count > 1) {
            self.deleteOptions.removeAtIndex(self.deleteOptions.count - index - 1)
        }
        else if (nullOps.contains(self.deleteOptions[0]) == false) {
            self.deleteOptions[0] = nullOps[self.typeNo]
        }
        self.story.dict.setValue(self.deleteOptions, forKey: self.storyLabels[typeNo])
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveStory(self.story)
        self.tableView.reloadData()
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
            self.titleText.setTitle("(Your entry) Prince of Denmark", forState: .Normal)
        case 1:
            self.titleText.setTitle("Harry Potter and the (Your Entry)", forState: .Normal)
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
        self.loadData()
        setText()
        self.deleteOptions = self.story.dict.valueForKeyPath(self.storyLabels[self.typeNo]) as! [String]
        self.tableView.reloadData()
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
        self.loadData()
        self.deleteOptions = self.story.dict.valueForKeyPath(self.storyLabels[self.typeNo]) as! [String]
        self.tableView.reloadData()
        self.toast.textColor = UIColor.blackColor()
        self.toast.hidden = false
        UIView.transitionWithView(self.toast, duration: 2.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {self.toast.hidden = false}, completion: nil)
        UIView.transitionWithView(self.toast, duration: 4.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {self.toast.hidden = true}, completion: nil)
//        UIView.animateWithDuration(
//            4.0, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
//                
//                self.toast.alpha = 0.0
//                
//            }, completion: nil)
    }
    
    
    // MARK: NSCoding
    // Loads data from story.plist
    func loadData() {
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
    
}
