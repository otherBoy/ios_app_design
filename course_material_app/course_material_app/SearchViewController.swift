//
//  SearchViewController.swift
//  course_material_app
//
//  Created by MIRKO on 4/21/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var sortingPicker: UIPickerView!
    
    @IBOutlet weak var freeSwitch: UISwitch!
    
    var pickerDataSource = ["Recent", "Price Desc", "Price Asc"];
    
    var resources = [
        Resource(title: "notes for ICOM6042", description: "Some test notes", price: 30.0 , type: "notes", image: "default", courseCode: "ICOM6042", preferContact: "email", exchange: "", addDate: NSDate()),
        Resource(title: "The hitchhiker's guide to E-Logistics for ECOM-6008", description: "great book in mint condition", price: 120.0 , type: "book", image: "default", courseCode: "ICOM6008", preferContact: "wechat", exchange: "", addDate: NSDate())
    ]
    
    var results = [
        Resource(title: "notes for ICOM6042", description: "Some test notes", price: 30.0 , type: "notes", image: "default", courseCode: "ICOM6042", preferContact: "wechat", exchange: "", addDate: NSDate()),
        Resource(title: "The hitchhiker's guide to E-Logistics for ECOM-6008", description: "great book in mint condition", price: 120.0 , type: "book", image: "default", courseCode: "ICOM6008", preferContact: "wechat", exchange: "", addDate: NSDate())
    ]
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.sortingPicker.dataSource = self;
        self.sortingPicker.delegate = self;
        
        
        freeSwitch.addTarget(self, action: #selector(SearchViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)

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
            resources = resources.filter {$0.title.lowercaseString.rangeOfString(keyword!.lowercaseString) != nil }
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            resources = results
            tableView.reloadData()
        }
        else if(row == 1)
        {
            resources.sortInPlace({$0.price < $1.price})
            tableView.reloadData()
        }
        else if(row == 2)
        {
            resources.sortInPlace({$0.title < $1.title})
            tableView.reloadData()
        }
        else
        {
            resources = results
            tableView.reloadData()
        }
    }
    
    func stateChanged(switchState: UISwitch){
        if switchState.on {
            resources = resources.filter {$0.price == 0.0}
            print(resources)
            print("switching!")
            tableView.reloadData()
        } else {
            resources = results
            tableView.reloadData()
        }
    }
    
    


}

