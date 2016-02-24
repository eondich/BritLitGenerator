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
    var titlePt1: [String]!
    var title1: String!
    var titlePt2: [String]!
    var title2: String!
    //    var titlePt3: [String]!
    //    var title3: String!
    var authors: [String]!
    var author: String!
    var style1: [String]!
    var stl1: String!
    var style2: [String]!
    var stl2: String!
    var settings: [String]!
    var setting: String!
    var heroPt1: [String]!
    var hero1: String!
    var heroPt2: [String]!
    var hero2: String!
    var companionPt1: [String]!
    var companion1: String!
    var companionPt2: [String]!
    var companion2: String!
    var villainsPt1: [String]!
    var villain1: String!
    var villainsPt2: [String]!
    var villain2: String!
    var conflicts: [String]!
    var conflict: String!
    var dramas: [String]!
    var drama: String!
    var conclusions: [String]!
    var conclusion: String!
    var index: Int!
    
    // MARK: Init
    // Default init
    // Default values are included for each of the lists in case they don't have values stored.  This is most useful for debugging.
    
    override init() {
        self.titlePt1 = ["[TITLE1]"]
        self.titlePt2 = ["[TITLE2]"]
        self.authors = ["[AUTHORS]"]
        self.style1 = ["[STYLE1]"]
        self.style2 = ["[STYLE2]"]
        self.settings = ["[SETTINGS]"]
        self.heroPt1 = ["[HERO1]"]
        self.heroPt2 = ["[HERO2]"]
        self.companionPt1 = ["[COMP1]"]
        self.companionPt2 = ["[COMP2]"]
        self.villainsPt1 = ["[VILL1]"]
        self.villainsPt2 = ["[VILL2]"]
        self.conflicts = ["[CONFLICT]"]
        self.dramas = ["[DRAMA]"]
        self.conclusions = ["[CONCLUSION]"]
    }
    
    // MARK: NSCoding
    // Init to load stored story pieces
    required init(coder aDecoder: NSCoder) {
        self.titlePt1 = aDecoder.decodeObjectForKey("title1") as! [String]
        self.titlePt2 = aDecoder.decodeObjectForKey("title2") as! [String]
        self.authors = aDecoder.decodeObjectForKey("authors") as! [String]
        self.style1 = aDecoder.decodeObjectForKey("style1") as! [String]
        self.style2 = aDecoder.decodeObjectForKey("style2") as! [String]
        self.settings = aDecoder.decodeObjectForKey("settings") as! [String]
        self.heroPt1 = aDecoder.decodeObjectForKey("heroPt1") as! [String]
        self.heroPt2 = aDecoder.decodeObjectForKey("heroPt2") as! [String]
        self.companionPt1 = aDecoder.decodeObjectForKey("compPt1") as! [String]
        self.companionPt2 = aDecoder.decodeObjectForKey("compPt2") as! [String]
        self.villainsPt1 = aDecoder.decodeObjectForKey("vills1") as! [String]
        self.villainsPt2 = aDecoder.decodeObjectForKey("vills2") as! [String]
        self.conflicts = aDecoder.decodeObjectForKey("conflicts") as! [String]
        self.dramas = aDecoder.decodeObjectForKey("dramas") as! [String]
        self.conclusions = aDecoder.decodeObjectForKey("conclusions") as! [String]
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(titlePt1, forKey: "title1")
        aCoder.encodeObject(titlePt2, forKey: "title2")
        aCoder.encodeObject(authors, forKey: "authors")
        aCoder.encodeObject(style1, forKey: "style1")
        aCoder.encodeObject(style2, forKey: "style2")
        aCoder.encodeObject(settings, forKey: "settings")
        aCoder.encodeObject(heroPt1, forKey: "heroPt1")
        aCoder.encodeObject(heroPt2, forKey: "heroPt2")
        aCoder.encodeObject(companionPt1, forKey: "compPt1")
        aCoder.encodeObject(companionPt2, forKey: "compPt2")
        aCoder.encodeObject(villainsPt1, forKey: "vills1")
        aCoder.encodeObject(villainsPt2, forKey: "vills2")
        aCoder.encodeObject(conflicts, forKey: "conflicts")
        aCoder.encodeObject(dramas, forKey: "dramas")
        aCoder.encodeObject(conclusions, forKey: "conclusions")
    }

    // MARK: Other methods
    // Uses a random number generator to get an index for each list of story pieces then sets the corresponding story piece value to the string at that index
    func getStory() {
        index = Int(arc4random_uniform(UInt32(titlePt1.count)))
        title1 = titlePt1[index]
        index = Int(arc4random_uniform(UInt32(titlePt2.count)))
        title2 = titlePt2[index]
        index = Int(arc4random_uniform(UInt32(authors.count)))
        author = authors[index]
        index = Int(arc4random_uniform(UInt32(style1.count)))
        stl1 = style1[index]
        index = Int(arc4random_uniform(UInt32(style2.count)))
        stl2 = style2[index]
        index = Int(arc4random_uniform(UInt32(settings.count)))
        setting = settings[index]
        index = Int(arc4random_uniform(UInt32(heroPt1.count)))
        hero1 = heroPt1[index]
        index = Int(arc4random_uniform(UInt32(heroPt2.count)))
        hero2 = heroPt2[index]
        index = Int(arc4random_uniform(UInt32(companionPt1.count)))
        companion1 = companionPt1[index]
        index = Int(arc4random_uniform(UInt32(companionPt2.count)))
        companion2 = companionPt2[index]
        index = Int(arc4random_uniform(UInt32(villainsPt1.count)))
        villain1 = villainsPt1[index]
        index = Int(arc4random_uniform(UInt32(villainsPt2.count)))
        villain2 = villainsPt2[index]
        index = Int(arc4random_uniform(UInt32(conflicts.count)))
        conflict = conflicts[index]
        index = Int(arc4random_uniform(UInt32(dramas.count)))
        drama = dramas[index]
        index = Int(arc4random_uniform(UInt32(conclusions.count)))
        conclusion = conclusions[index]
    }
    
    
}
