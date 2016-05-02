//
//  SearchViewController.swift
//  course_material_app
//
//  Created by MIRKO on 4/21/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var searchField: UITextField!
    
    
    
    var resources = [
        Resource(title: "notes for ICOM6042", description: "Some test notes", price: 30.0 , type: "notes", image: "default", courseCode: "ICOM6042", preferContact: "email"),
        Resource(title: "The hitchhiker's guide to E-Logistics for ECOM-6008", description: "great book in mint condition", price: 120.0 , type: "book", image: "default", courseCode: "ICOM6008", preferContact: "wechat")
    ]
    
    var results = [
        Resource(title: "notes for ICOM6042", description: "Some test notes", price: 30.0 , type: "notes", image: "default", courseCode: "ICOM6042", preferContact: "email"),
        Resource(title: "The hitchhiker's guide to E-Logistics for ECOM-6008", description: "great book in mint condition", price: 120.0 , type: "book", image: "default", courseCode: "ICOM6008", preferContact: "wechat")
    ]
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resources.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // reloading table data after change
//        let cell = tableView.dequeueReusableCellWithIdentifier("resCell")!
        let res = self.resources[indexPath.row]
        
        let cellIdentifier = "resCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ResourceTableViewCell
        
        // Set the title and image
        cell.titleLable.text = res.title
        cell.cellDescription.text = res.description

        
//        // If the cell has a detail label, insert post description
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = res.description
//        }
        
        return cell
    }
    
    
    @IBAction func search(sender: AnyObject) {
        let keyword = searchField.text
        
        if keyword == "" {
            resources = results
            tableView.reloadData()
        } else {
            resources = resources.filter {$0.title.rangeOfString(keyword!) != nil}
            tableView.reloadData()
        }
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // present detail view when a cell is pressed
        performSegueWithIdentifier("detailSegue", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow, let resource = resources[indexPath.row] as? Resource  {
                let destinationViewController = segue.destinationViewController as! ResourceDetailViewController
                destinationViewController.resource = resource
            }
        }
    }

    
    


}

