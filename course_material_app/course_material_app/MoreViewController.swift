//
//  MoreViewController.swift
//  course_material_app
//
//  Created by MIRKO on 4/21/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("loggedIn") {
            logout.hidden = false
            logout.setTitle("Logout", forState: UIControlState.Normal)
            logout.enabled = true
        } else {
            logout.enabled = false
            logout.setTitle("Login to logout!", forState: UIControlState.Normal)
        }
    }
    
    @IBOutlet weak var logout: UIButton!
    
    
    @IBAction func logout(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "loggedIn")
        
        _ = Server.sharedInstance().logout() { jsonResult, error in
            if let error = error {
                print("Error searching for actors: \(error.localizedDescription)")
                return
            }
        
            if let _ = jsonResult  {
                dispatch_async(dispatch_get_main_queue()) {
                    self.logout.setTitle("You logged out!", forState: UIControlState.Normal)
                }
            }
            
        }
        
    }
    
    
}