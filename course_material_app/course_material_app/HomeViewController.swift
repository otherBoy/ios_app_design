//
//  HomeViewController.swift
//  course_material_app
//
//  Created by MIRKO on 4/21/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    
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
            loginBtn.hidden = true
        } else {
            loginBtn.hidden = false
            loginBtn.enabled = true
            loginBtn.setTitle("Login", forState: UIControlState.Normal)
        }
    }

}