//
//  StoryBits.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 1/12/16.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//
// StoryBits has lists of possible values for parts of a story as well as one string to correspond with each list.  I'll probably split this up into two classes in the future.
// This class stores data that is then used to generate a random story

import UIKit

class StoryBits: NSObject, NSCoding {
    // To do: Add a way to save a specific story
    //      - Maybe add the third part of the title (included in the original project by Casey Dallavalle, Anna Courchaine, and Elena, but unnecessary- it runs along the lines of ": A Novel" or ": A Modest Proposal")
    
    // The lists here hold strings that are used to create a story.  conclusions, for example, holds all the possible conclusions.  Elements are randomly selected from each list to make a complete story.
    var dict: NSMutableDictionary!
    var title1: String!
    var title2: String!
    var author: String!
    var style1: String!
    var style2: String!
    var setting: String!
    var hero1: String!
    var hero2: String!
    var companion1: String!
    var companion2: String!
    var villain1: String!
    var villain2: String!
    var conflict: String!
    var drama: String!
    var conclusion: String!
    var index: Int!
    
    // MARK: Init
    // Default init
    // Default values are included for each of the lists in case they don't have values stored.  This is most useful for debugging.
    
    override init() {
        self.dict = NSMutableDictionary()
        self.dict.setValue(["[TITLE1]"], forKey: "title1")
        self.dict.setValue(["[TITLE2]"], forKey: "title2")
        self.dict.setValue(["[AUTHORS]"], forKey: "author")
        self.dict.setValue(["[STYLE1"], forKey: "style1")
        self.dict.setValue(["STYLE2"], forKey: "style2")
        self.dict.setValue(["SETTINGS"], forKey: "settings")
        self.dict.setValue(["HERO1"], forKey: "hero1")
        self.dict.setValue(["HERO2"], forKey: "hero2")
        self.dict.setValue(["COMP1"], forKey: "comp1")
        self.dict.setValue(["VILL1"], forKey: "vill1")
        self.dict.setValue(["VILL2"], forKey: "vill2")
        self.dict.setValue(["CONFLICT"], forKey: "conflict")
        self.dict.setValue(["DRAMA"], forKey: "drama")
        self.dict.setValue(["CONCLUSION"], forKey: "conclusion")
    }
    
    // MARK: NSCoding
    // Init to load stored story pieces
    required init(coder aDecoder: NSCoder) {
        self.dict = aDecoder.decodeObjectForKey("dict") as! NSMutableDictionary
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(dict, forKey: "dict")
    }

    // MARK: Other methods
    // Uses a random number generator to get an index for each list of story pieces then sets the corresponding story piece value to the string at that index
    // See if you can make separate fcn for this
    func getStory() {
        var curArray = self.dict.valueForKeyPath("title1") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.title1 = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("title2") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.title2 = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("author") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.author = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("style1") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.style1 = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("style2") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.style2 = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("setting") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.setting = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("hero1") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.hero1 = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("hero2") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.hero2 = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("comp1") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.companion1 = curArray![index] as! String
        if self.companion1 == "their deeply felt angst" {
            self.companion2 = "was practically a physical entity"
        }
        else {
            curArray = self.dict.valueForKeyPath("comp2") as? NSArray
            index = Int(arc4random_uniform(UInt32(curArray!.count)))
            self.companion2 = curArray![index] as! String
        }
        curArray = self.dict.valueForKeyPath("vill1") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.villain1 = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("vill2") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.villain2 = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("conflict") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.conflict = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("drama") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.drama = curArray![index] as! String
        curArray = self.dict.valueForKeyPath("conclusion") as? NSArray
        index = Int(arc4random_uniform(UInt32(curArray!.count)))
        self.conclusion = curArray![index] as! String
    }
    
    
}
