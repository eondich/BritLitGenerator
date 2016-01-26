//
//  ChooseAddTypeViewController.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 1/22/16.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//

import UIKit

class ChooseAddTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var labels: [String]!
    var navBar: UINavigationBar!
    var backButton: UIBarButtonItem!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        // To do: Fix back button
        //      - Aesthetics?
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Labels for the cells
        self.labels = ["[Title Part 1]", "[Title Part 2]", "Written by...", "Told in...", "Chock full of...", "Once upon a time, in a...", "there was...", "our hero, who...", "accompanied by...", "their companion, who...", "They came into conflict with...", "this story's antagonist, which/who...", "The cause of the strife was...", "culminating in...", "In the end..."]
        
        // Set up the table view itself
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.frame = CGRectMake(0, 50, 320, 200)
        self.view.addSubview(tableView)
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Set up the navigation bar
        self.navBar = UINavigationBar()
        self.navBar.translatesAutoresizingMaskIntoConstraints = false
        self.navBar.backgroundColor = UIColor.grayColor()
        self.view.addSubview(navBar)
        
        // This is what the internet keeps telling me to do to set up a back button on the navigation bar, but it is definitely not working.  Addressing this is one of my next steps
        backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "back")
        self.navigationItem.leftBarButtonItem = backButton
        
        // Set up constraints
        let views: [String:AnyObject] = ["navBar": navBar,
            "tableView": tableView,
            "topLayoutGuide": topLayoutGuide,
            "bottomLayoutGuide": bottomLayoutGuide]
        let metrics: [String:Int] = ["navHeight": 70]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[navBar]-[tableView]-[bottomLayoutGuide]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[navBar]-|", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[tableView]-|", options: [], metrics: metrics, views: views))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // I want there to be as many rows/cells as there are cell labels in my list
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    // Cell labels are taken from the labels list
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell!
        
        cell.textLabel?.text = self.labels[indexPath.row]
        
        return cell
    }
    
    // When I select a row, I want to go to AddDataViewController, where I can add data to the lists of pieces of stories
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc:AddDataViewController = AddDataViewController()
        let cell = tableView.cellForRowAtIndexPath(tableView.indexPathForSelectedRow!)
        // This sets the textLabel variable in the AddDataViewController to match the text in the cell so it can be used as a heading and remind users which type of data they're adding
        vc.newText = cell?.textLabel?.text
        // This basically gives the AddDataViewController a way to identify which cell was chosen to get to it, which allows it to save new data to the appropriate place
        vc.typeNo = indexPath.row + 1
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // I would love for the back button to take the user back to the main screen using this function, but no such button even shows up yet.  To be tested later.
    func back() {
        let vc:NoStoryboardViewController = NoStoryboardViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}
