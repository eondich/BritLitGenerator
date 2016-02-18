//
//  ChooseAddTypeViewController.swift
//  The Wonderific British Literature Generator for the Common Fluckadrift
//
//  Created by Elena Ondich on 1/22/16.
//  Copyright © 2016 Elena Ondich. All rights reserved.
//

import UIKit

protocol ChooseTypeControllerDelegate {
    func typeWasSelected(newTypeNo: Int, newTypeText: String) -> Void
    // Change var name
}

class ChooseAddTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    var labels: [String]!
    var tableView: UITableView!
    var delegate: ChooseTypeControllerDelegate?
    
    override func viewDidLoad() {
        // To do: Fix back button
        //      - Aesthetics?
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.popoverPresentationController?.delegate = self
        
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
        
        
        // Set up constraints
        let views: [String:AnyObject] = ["tableView": tableView,
            "topLayoutGuide": topLayoutGuide,
            "bottomLayoutGuide": bottomLayoutGuide]
        let metrics: [String:Int] = ["margin": 10]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[tableView]-[bottomLayoutGuide]", options: [], metrics: metrics, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[tableView]-|", options: [], metrics: metrics, views: views))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func showInViewController(vc: UIViewController, button: UIButton) {
//        vc.presentViewController(self, animated: true, completion: nil)
//        let presentationController = self.popoverPresentationController
//        presentationController?.sourceView = button
//        presentationController?.sourceRect = button.bounds
//    }
    
    
    
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
        self.dismissViewControllerAnimated(true, completion: nil)
        if let _ = self.delegate {
            self.delegate!.typeWasSelected(indexPath.row + 1, newTypeText: self.labels[indexPath.row])
        }
    }
    
}
