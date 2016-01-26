//
//  NoStoryboardViewController.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 1/6/16 with help from Jeffrey Ondich.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//

import UIKit

class NoStoryboardViewController: UIViewController {
    // To do: Have a random story populate when the view loads
    //      - Make it at all pretty
    //      - There seems to be a bug where the styles are showing up wrong.  Will investigate.
    var storyTitle: UITextView!
    var storyAuthor: UITextView!
    var storyPlot: UITextView!
    var style: UITextView!
    var button: UIButton!
    var index: Int!
    var dataButton: UIButton!
    var buttonOps: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        let font = UIFont.systemFontOfSize(14.0)
        
        // Title
        self.storyTitle = UITextView()
        self.storyTitle.translatesAutoresizingMaskIntoConstraints = false
        self.storyTitle.backgroundColor = UIColor.redColor()
        self.storyTitle.font = font
        self.storyTitle.text = "Harry Potter and The Chamber of Your Title"
        self.storyTitle.textAlignment = .Center
        self.storyTitle.editable = false
        self.view.addSubview(self.storyTitle)
        
        // Author
        self.storyAuthor = UITextView()
        self.storyAuthor.translatesAutoresizingMaskIntoConstraints = false
        self.storyAuthor.backgroundColor = UIColor.greenColor()
        self.storyAuthor.font = font
        self.storyAuthor.text = "WRITTEN BY: Yourself, dear reader"
        self.storyAuthor.editable = false
        self.view.addSubview(self.storyAuthor)
        
        // Style
        self.style = UITextView()
        self.style.translatesAutoresizingMaskIntoConstraints = false
        self.style.backgroundColor = UIColor.blueColor()
        self.style.font = font
        self.style.text = "This story is told in Newspeak"
        self.style.editable = false
        self.view.addSubview(style)
        
        // Plot
        self.storyPlot = UITextView()
        self.storyPlot.translatesAutoresizingMaskIntoConstraints = false
        self.storyPlot.backgroundColor = UIColor.orangeColor()
        self.storyPlot.font = font
        self.storyPlot.text = "Your hero sets out on a grand adventure to find a long lost treasure.  In the end, they finally go to the lighthouse."
        self.storyPlot.editable = false
        self.view.addSubview(self.storyPlot)
        
        // Button to get a new random story
        self.button = UIButton()
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.button.setTitle("Hit me, knave!", forState: UIControlState.Normal)
        self.button.sizeToFit() // Makes the button the size determined by its text
        self.button.addTarget(self, action: "handleHitMeButton", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.button)
        
        // Button to add text options for when a story randomly generates.  Might want to make more obvious
        self.dataButton = UIButton()
        self.dataButton.translatesAutoresizingMaskIntoConstraints = false
        self.dataButton.setTitle("+", forState: UIControlState.Normal)
        self.dataButton.sizeToFit()
        self.dataButton.addTarget(self, action: "addData", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.dataButton)
        
        // A list of text for the button that gives the user a new story
        self.buttonOps = ["Hit me, knave!", "Hit me, rogue!", "Hit me, foulmouthed braggard!", "Hit me, though I am sore afraid!", "Hit me, oh light of my soul!"]
        
        // Transparent views to arrange for the centering of the button
        let leftButtonPad: UIView = UIView()
        leftButtonPad.translatesAutoresizingMaskIntoConstraints = false
        leftButtonPad.backgroundColor = UIColor.clearColor()
        self.view.addSubview(leftButtonPad)
        
        let rightButtonPad: UIView = UIView()
        rightButtonPad.translatesAutoresizingMaskIntoConstraints = false
        rightButtonPad.backgroundColor = UIColor.clearColor()
        self.view.addSubview(rightButtonPad)
        
        
        // Set up constraints
        
        let views: [String:AnyObject] = ["title":self.storyTitle,
            "author":self.storyAuthor,
            "style":self.style,
            "plot":self.storyPlot,
            "button":self.button,
            "data":self.dataButton,
            "leftButtonPad":leftButtonPad,
            "rightButtonPad":rightButtonPad,
            "topLayoutGuide":self.topLayoutGuide,
            "bottomLayoutGuide":self.bottomLayoutGuide]
        
        let metrics: [String:Float] = ["margin":20, "titleHeight":40, "authorHeight":30, "styleHeight":30]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[title]-margin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[data]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[author]-margin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[style]-margin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[plot]-margin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[leftButtonPad][button][rightButtonPad(==leftButtonPad)]|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-margin-[title(titleHeight)][author(authorHeight)][style(styleHeight)][plot]-margin-[button]-margin-[bottomLayoutGuide]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-margin-[data]", options: [], metrics: metrics, views: views))
    }
    
    // Run when the button to get a new story is pressed
    func handleHitMeButton() {
        // Get a random number that is between 0 and the length of the buttonOps list and then use that number to choose the new text for the button from buttonOps
        index = Int(arc4random_uniform(UInt32(buttonOps.count)))
        self.button.setTitle(buttonOps[index], forState: UIControlState.Normal)
        
        // Create a new StoryBits object and load the lists of options for pieces of the story
        var story = StoryBits()
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let storyURL = documentsURL.URLByAppendingPathComponent("story.plist")
        if let data = NSData(contentsOfURL:storyURL) {
            story = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! StoryBits
        }
        
        // Get a random story
        story.getStory()
        // Populate the title, author, style, and plot boxes with the values that were randomly chosen by getStory()
        storyTitle.text = "\(story.title1) \(story.title2)"
        storyAuthor.text = "Written by \(story.author)"
        style.text = "Told in \(story.style1) chock full of \(story.style2)"
        storyPlot.text = "Once upon a time \(story.setting) there was \(story.hero1) who \(story.hero2) accompanied by \(story.companion1) who \(story.companion2).  They came into conflict with \(story.villain1) who \(story.villain2) because of/over \(story.conflict) culminating in \(story.drama).  In the end, \(story.conclusion)."
    }
    
    // Changes to the view controller where the user picks the kind of data they want to add
    func addData() {
        let vc:ChooseAddTypeViewController = ChooseAddTypeViewController()
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
}
