//
//  RandomStoryViewController.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 1/6/16 with help from Jeffrey Ondich.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//
// This is the main view controller, where stories are randomly generated and displayed

import UIKit

class RandomStoryViewController: UIViewController {
    // To do: Make it at all pretty
    var storyTitle: UITextView!
    var storyPlot: UITextView!
    var button: UIButton!
    var index: Int!
    var dataButton: UIButton!
    var buttonOps: [String]!
    var story: StoryBits!
    var storyPieceSwitch: UISwitch!
    var fontColor: UIColor!
    var font: UIFont!
    var backgroundColor: UIColor!
    var titleFont: UIFont!
    var titleColor: UIColor!
    var highlightColor: UIColor!
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View defaults
        self.navigationItem.title = "Your story"
        self.view.backgroundColor = UIColor(red: 0.2, green: 0.33, blue: 0.0, alpha: 1.0)
        self.font = UIFont.systemFontOfSize(14.0)
        self.titleColor = UIColor(red: 0.8, green: 0.52, blue: 0.0, alpha: 1.0)
        self.fontColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        self.backgroundColor = UIColor(red: 1.0, green: 0.97, blue: 0.9, alpha: 1.0)
        let buttonColor = UIColor(red: 0.55, green: 0.2, blue: 0.0, alpha: 1.0)
        self.titleFont = UIFont.systemFontOfSize(18.0)
        self.highlightColor = UIColor(red: 0.12, green: 0.47, blue: 0.69, alpha: 1.0)
        
        // Create a new StoryBits object and load the lists of options for pieces of the story
        story = StoryBits()
        loadData()
        
        // Get an initial random story
        story.getStory()
        
        // Title
        self.storyTitle = UITextView()
        self.storyTitle.translatesAutoresizingMaskIntoConstraints = false
        self.storyTitle.backgroundColor = backgroundColor
        self.storyTitle.font = self.titleFont
        self.storyTitle.textColor = titleColor
        self.storyTitle.text = "\(story.title1) \(story.title2)"
        self.storyTitle.textAlignment = .Center
        self.storyTitle.editable = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.storyTitle)
        
        // Plot
        self.storyPlot = UITextView()
        self.storyPlot.translatesAutoresizingMaskIntoConstraints = false
        self.storyPlot.backgroundColor = backgroundColor
        self.storyPlot.textColor = self.fontColor
        formatPlot(NSMutableAttributedString(string: "Written by|\(story.author)\r\rTold in|\(story.style1) chock full of|\(story.style2)\r\rOnce upon a time|\(story.setting), there was|\(story.hero1) who|\(story.hero2), accompanied by|\(story.companion1) who[\(story.companion2).  They came into conflict with|\(story.villain1), who]\(story.villain2), because of|\(story.conflict).  The adventure culminated in|\(story.drama).  In the end,|\(story.conclusion).|"))
        self.storyPlot.editable = false
        self.view.addSubview(self.storyPlot)
        
        // Button to get a new random story
        self.button = UIButton()
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.button.backgroundColor = buttonColor
        self.button.setTitle(" Hit me, knave! ", forState: UIControlState.Normal)
        self.button.layer.cornerRadius = 8
        self.button.sizeToFit() // Makes the button the size determined by its text
        self.button.addTarget(self, action: "handleHitMeButton", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.button)
        
        self.storyPieceSwitch = UISwitch(frame: CGRectMake(120, 240, 0, 0))
        self.storyPieceSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.storyPieceSwitch.on = false
        self.storyPieceSwitch.setOn(false, animated: true)
        self.storyPieceSwitch.addTarget(self, action: "showPieces:", forControlEvents: .ValueChanged)
        self.view.addSubview(storyPieceSwitch)
        
        // A list of text options for the button that gives the user a new story
        self.buttonOps = [" Hit me, knave! ", " Hit me, rogue! ", " Hit me, foulmouthed braggard! ", " Hit me, though I am sore afraid! ", " Hit me, oh light of my soul! "]
        
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
            "plot":self.storyPlot,
            "button":self.button,
            "switch":self.storyPieceSwitch,
            "leftButtonPad":leftButtonPad,
            "rightButtonPad":rightButtonPad,
            "topLayoutGuide":self.topLayoutGuide,
            "bottomLayoutGuide":self.bottomLayoutGuide]
        
        let metrics: [String:Float] = ["margin":20, "titleHeight":43, "buttonHeight":37, "styleHeight":43, "switchMargin":30]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[title]-margin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[plot]-margin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[leftButtonPad][button][rightButtonPad(==leftButtonPad)]|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-margin-[title(titleHeight)][plot]-margin-[button(buttonHeight)]-margin-[bottomLayoutGuide]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[switch]-switchMargin-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[switch]-switchMargin-[button]-margin-[bottomLayoutGuide]", options: [], metrics: metrics, views: views))
    }
    
    // MARK: Button handling
    // Run when the button to get a new story is pressed
    func handleHitMeButton() {
        // Get a random number that is between 0 and the length of the buttonOps list and then use that number to choose the new text for the button from buttonOps
        loadData()
        index = Int(arc4random_uniform(UInt32(buttonOps.count)))
        self.button.setTitle(buttonOps[index], forState: UIControlState.Normal)
        
        // Get a random story
        story.getStory()
        // Populate the title, author, style, and plot boxes with the values that were randomly chosen by getStory()
        storyTitle.text = "\(story.title1) \(story.title2)"
        storyPlot.attributedText = NSAttributedString(string:"Written by|\(story.author)\r\rTold in|\(story.style1) chock full of|\(story.style2)\r\rOnce upon a time|\(story.setting), there was|\(story.hero1) who|\(story.hero2), accompanied by|\(story.companion1) who[\(story.companion2).  They came into conflict with|\(story.villain1), who]\(story.villain2), because of|\(story.conflict).  The adventure culminated in|\(story.drama).  In the end,|\(story.conclusion).|")
        showPieces(self.storyPieceSwitch)
    }
    
    func showPieces(sender:UISwitch!) {
        if (sender.on == true) {
            let plot = self.storyPlot.attributedText.string
            var mutablePlot = NSMutableAttributedString(string: plot)
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: "Written by|", endSubstring: "Told in|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: "Told in|", endSubstring: "chock full of|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: "chock full of|", endSubstring: "Once upon a time|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: "Once upon a time|", endSubstring: ", there was|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: ", there was|", endSubstring: "who|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: "who|", endSubstring: ", accompanied by|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: "accompanied by|", endSubstring: "who[")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: "who[", endSubstring: ".  They came into conflict with|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: ".  They came into conflict with|", endSubstring: ", who]")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: ", who]", endSubstring: ", because of|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: ", because of|", endSubstring: ".  The adventure culminated in|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: ".  The adventure culminated in|", endSubstring: ".  In the end,|")
            mutablePlot = changeSubstringColor(mutablePlot, startSubstring: ".  In the end,|", endSubstring: ".|")
            mutablePlot.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, mutablePlot.length))
            formatPlot(mutablePlot)
            let title = NSMutableAttributedString(string: self.storyTitle.attributedText.string, attributes: [NSFontAttributeName: self.titleFont, NSForegroundColorAttributeName: self.highlightColor])
            let midIndex = title.string.startIndex.distanceTo(self.story.title1.endIndex)
            title.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, midIndex))
            title.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(midIndex + 1, title.length - midIndex - 1))
            self.storyTitle.attributedText = title
            self.storyTitle.textAlignment = .Center
        }
        else {
            self.storyPlot.textColor = self.fontColor
            formatPlot(NSMutableAttributedString(string: self.storyPlot.attributedText.string))
            let titleString = self.storyTitle.attributedText.string
            let title = NSMutableAttributedString(string: titleString, attributes: [NSFontAttributeName: self.titleFont])
            self.storyTitle.attributedText = formatTitle(title, titleColor: self.titleColor)
            self.storyTitle.textAlignment = .Center
        }
    }
    
    func formatPlot(var mutablePlot: NSMutableAttributedString) {
        mutablePlot = addWhitespace("Written by|", plot: mutablePlot)
        mutablePlot = addWhitespace("Told in|", plot: mutablePlot)
        mutablePlot = addWhitespace("chock full of|", plot: mutablePlot)
        mutablePlot = addWhitespace("Once upon a time|", plot: mutablePlot)
        mutablePlot = addWhitespace("there was|", plot: mutablePlot)
        mutablePlot = addWhitespace("who|", plot: mutablePlot)
        mutablePlot = addWhitespace("accompanied by|", plot: mutablePlot)
        mutablePlot = addWhitespace("who[", plot: mutablePlot)
        mutablePlot = addWhitespace(".  They came into conflict with|", plot: mutablePlot)
        mutablePlot = addWhitespace("who]", plot: mutablePlot)
        mutablePlot = addWhitespace(", because of|", plot: mutablePlot)
        mutablePlot = addWhitespace(".  The adventure culminated in|", plot: mutablePlot)
        mutablePlot = addWhitespace(".  In the end,|", plot: mutablePlot)
        mutablePlot = addWhitespace(".|", plot: mutablePlot)
        mutablePlot.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, mutablePlot.length))
        self.storyPlot.attributedText = mutablePlot
    }
    
//    func formatTitle(newTitleColor: UIColor) {
//        let title = NSMutableAttributedString(string: self.storyTitle.attributedText.string, attributes: [NSFontAttributeName: self.titleFont, NSForegroundColorAttributeName: newTitleColor])
//        self.storyTitle.attributedText = title
//    }
    func formatTitle(fullString: NSMutableAttributedString, titleColor: UIColor) -> NSMutableAttributedString {
        let startIndex = 0
        let endIndex = fullString.length
        fullString.addAttribute(NSForegroundColorAttributeName, value: titleColor, range: NSMakeRange((startIndex), (endIndex - startIndex)))
        return fullString
    }
    
    func addWhitespace(stringToEdit: String, plot: NSMutableAttributedString) -> NSMutableAttributedString {
        let index = plot.string.startIndex.distanceTo((plot.string.rangeOfString(stringToEdit)?.endIndex)!)
        plot.addAttribute(NSForegroundColorAttributeName, value: self.backgroundColor, range: NSMakeRange(index - 1, 1))
        return plot
    }
    
    func changeSubstringColor(var fullString: NSMutableAttributedString, startSubstring: String, endSubstring: String) -> NSMutableAttributedString {
        let fullStart = fullString.string.startIndex
        let stringRange = fullString.string.rangeOfString(startSubstring)
        let startIndex = fullStart.distanceTo(stringRange!.endIndex)
        let endIndex = fullString.string.startIndex.distanceTo((fullString.string.rangeOfString(endSubstring)?.startIndex)!)
        fullString = addWhitespace(startSubstring, plot: fullString)
        fullString = addWhitespace(endSubstring, plot: fullString)
        fullString.addAttribute(NSForegroundColorAttributeName, value: self.highlightColor, range: NSMakeRange((startIndex), (endIndex - startIndex)))
        fullString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange((startIndex), (endIndex - startIndex)))
        return fullString
    }
    
    // MARK: NSCoding
    // Loads story data
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
