//
//  DeleteViewController.swift
//  BritLitGenerator
//
//  Created by Elena Ondich on 2/22/16.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//
// In this view controller, the user can delete text that is in the lists used to randomly generate stories

import UIKit

class DeleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChooseTypeControllerDelegate, UIPopoverPresentationControllerDelegate {
    var chooseTypeBox: UIButton!
    var storyPieces: StoryBits!
    var deleteOptions: [String]!
    var tableView: UITableView!
    var backgroundColor: UIColor!
    var typeNo: Int!
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // deleteOptions is the list of story pieces that can currently be deleted.
        loadData()
        deleteOptions = self.storyPieces.titlePt1
        self.typeNo = 0
        
        // Basic variables/appearance setup
        self.navigationItem.title = "Delete content"
        let borderColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
        let buttonColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        self.backgroundColor = UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1.0)
        let textColor = UIColor(red: 0.4, green: 0.75, blue: 0.55, alpha: 1.0)
        self.view.backgroundColor = backgroundColor
        
        // A header box where you can select the kind of data you want to delete
        self.chooseTypeBox = UIButton()
        self.chooseTypeBox.translatesAutoresizingMaskIntoConstraints = false
        self.chooseTypeBox.backgroundColor = buttonColor
        self.chooseTypeBox.setTitleColor(textColor, forState: .Normal)
        self.chooseTypeBox.layer.borderColor = borderColor.CGColor
        self.chooseTypeBox.layer.borderWidth = 1
        self.chooseTypeBox.layer.cornerRadius = 8
        self.chooseTypeBox.setTitle("[Title Part 1]", forState: .Normal)
        self.chooseTypeBox.addTarget(self, action: "getOptions:", forControlEvents: .TouchUpInside)
        self.view.addSubview(chooseTypeBox)
        
        // Shows options of data to delete
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.frame = CGRectMake(0, 50, 320, 200)
        self.tableView.backgroundColor = backgroundColor
        self.view.addSubview(tableView)
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Constraints
        let views: [String:AnyObject] = ["chooseBox":chooseTypeBox,
                                        "tableView":tableView,
                                        "topLayoutGuide":topLayoutGuide,
                                        "bottomLayoutGuide":bottomLayoutGuide]
        
        let metrics: [String:Float] = ["margin":10]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-margin-[chooseBox]-margin-[tableView]-[bottomLayoutGuide]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[chooseBox]-margin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[tableView]-|", options: [], metrics: metrics, views: views))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.textLabel?.text = self.deleteOptions[indexPath.row]
        cell.backgroundColor = self.backgroundColor
        return cell
    }
    
    // If a row is selected, displays an alert.  If delete is selected, deletes the data displayed in the selected row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Hold on-", message: "Are you sure you want to delete this data?", preferredStyle: .Alert)
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
            self.deleteOptions.removeAtIndex(index)
        }
        else if (nullOps.contains(self.deleteOptions[0]) == false) {
            self.deleteOptions[0] = nullOps[self.typeNo]
        }
        self.saveList()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.saveStory(self.storyPieces)
        self.tableView.reloadData()
    }
    
    // Updates a list in storyPieces to match deleteOptions based on typeNo (the type of data that can currently be deleted)
    func saveList() {
        switch self.typeNo {
        case 0:
            self.storyPieces.titlePt1 = self.deleteOptions
        case 1:
            self.storyPieces.titlePt2 = self.deleteOptions
        case 2:
            self.storyPieces.authors = self.deleteOptions
        case 3:
            self.storyPieces.style1 = self.deleteOptions
        case 4:
            self.storyPieces.style2 = self.deleteOptions
        case 5:
            self.storyPieces.settings = self.deleteOptions
        case 6:
            self.storyPieces.heroPt1 = self.deleteOptions
        case 7:
            self.storyPieces.heroPt2 = self.deleteOptions
        case 8:
            self.storyPieces.companionPt1 = self.deleteOptions
        case 9:
            self.storyPieces.companionPt2 = self.deleteOptions
        case 10:
            self.storyPieces.villainsPt1 = self.deleteOptions
        case 11:
            self.storyPieces.villainsPt2 = self.deleteOptions
        case 12:
            self.storyPieces.conflicts = self.deleteOptions
        case 13:
            self.storyPieces.dramas = self.deleteOptions
        case 14:
            self.storyPieces.conclusions = self.deleteOptions
        default:
            self.tableView.reloadData()
        }
    }
    
    // MARK: Popover
    // Calls a popover that displays data type options (ChooseAddTypeViewController)
    func getOptions(sender: UIButton!) {
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
    
    // Makes the popover behave like a popover in iPhone
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    // Updates the view controller when a new type of data is selected from the popover
    func typeWasSelected(newTypeNo: Int, newTypeText: String) {
        self.loadData()
        let sameTextList = [0, 1, 2, 3, 4, 7, 9, 11, 12, 13, 14]
        self.typeNo = newTypeNo
        if sameTextList.contains(newTypeNo) {
            self.chooseTypeBox.setTitle(newTypeText, forState: .Normal)
        }
        else {
            setText()
        }
        self.updateCells()
        self.tableView.reloadData()
    }

    // Updates the table with data from the story file based on typeNo, which is set based on the data type selected in the popover
    func updateCells() {
        var finList: [String]!
        switch self.typeNo {
        case 0:
            finList = self.storyPieces.titlePt1
        case 1:
            finList = self.storyPieces.titlePt2
        case 2:
            finList = self.storyPieces.authors
        case 3:
            finList = self.storyPieces.style1
        case 4:
            finList = self.storyPieces.style2
        case 5:
            finList = self.storyPieces.settings
        case 6:
            finList = self.storyPieces.heroPt1
        case 7:
            finList = self.storyPieces.heroPt2
        case 8:
            finList = self.storyPieces.companionPt1
        case 9:
            finList = self.storyPieces.companionPt2
        case 10:
            finList = self.storyPieces.villainsPt1
        case 11:
            finList = self.storyPieces.villainsPt2
        case 12:
            finList = self.storyPieces.conflicts
        case 13:
            finList = self.storyPieces.dramas
        case 14:
            finList = self.storyPieces.conclusions
        default:
            finList = []
        }
        self.deleteOptions = finList
    }
    
    // Sets the text in the chooseTypeBox based on typeNo (the type of data you can delete at the moment)
    func setText() {
        switch self.typeNo {
        case 5:
            self.chooseTypeBox.setTitle("Where does this story take place?", forState: .Normal)
        case 6:
            self.chooseTypeBox.setTitle("Who/what is your hero?", forState: .Normal)
        case 8:
            self.chooseTypeBox.setTitle("Who/what is your sidekick?", forState: .Normal)
        case 10:
            self.chooseTypeBox.setTitle("Who/what is your villain?", forState: .Normal)
        default:
            self.chooseTypeBox.setTitle("", forState: .Normal)
        }
    }
    
    // MARK: NSCoding
    // Loads data from story.plist
    func loadData() {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let storyURL = documentsURL.URLByAppendingPathComponent("story.plist")
        if let data = NSData(contentsOfURL:storyURL) {
            self.storyPieces = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! StoryBits
        }
    }

}
