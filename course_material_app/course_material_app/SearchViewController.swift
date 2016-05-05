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
    var fetchTask: NSURLSessionDataTask?
    
    @IBOutlet weak var freeSwitch: UISwitch!
    
    var pickerDataSource = ["Recent", "Price Desc", "Price Asc"];
    
    var results = [Resource]()
    
    var resources = [Resource]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.sortingPicker.dataSource = self;
        self.sortingPicker.delegate = self;
        
        
        freeSwitch.addTarget(self, action: #selector(SearchViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)

        // Do any additional setup after loading the view, typically from a nib.
        
        fetchTask = Server.sharedInstance().taskForResource() { jsonResult, error in
            if let error = error {
                print("Error searching for actors: \(error.localizedDescription)")
                return
            }
            
            if let resources = jsonResult as? [[String : AnyObject]] {
                print(resources)
//                let formatter = NSDateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                
//                for resource in resources {
////                    let date = String(resource["POSTED_DATE"])
////                    self.resources_try.append(Resource(title: (resource["TITLE"] as! String), description: (resource["DESCRIPTION"] as! String), price: resource["PRICE"]!.floatValue, type: (resource["TYPE"] as! String), image: "default", courseCode: (resource["COURSE_CODE"] as! String), preferContact: (resource["PREFER_CONTACT"] as! Int), exchange: (resource["EXCHANGE"] as! String), addDate: formatter.dateFromString(date)))
//                    
//                }
                
                self.results = resources.map() {
                    Resource(dictionary: $0)
                }
                
                print(self.results)
                self.resources = self.results
                // Reload the table on the main thread
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
            
        }
        
        
        
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

