//
//  SearchViewController.swift
//  course_material_app
//
//  Created by MIRKO on 4/21/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var resources = [
        Resource(title: "ICOM6042 notes", description: "notes from the course, includes cheatsheet for the exam"),
        Resource(title: "ICOM6042 book", description: "great shape, mint condition")
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // present detail view when a cell is pressed
        
    }
    
    


}

