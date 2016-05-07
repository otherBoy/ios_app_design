//
//  ProfileViewController.swift
//  course_material_app
//
//  Created by Robert Wei on 4/21/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation


import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var universityTF: UITextField!
    @IBOutlet var facultyTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var whatsappTF: UITextField!

    @IBOutlet var backBtn: UIButton!
    @IBOutlet var editBtn: UIButton!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("loggedIn") {
            editBtn.setTitle("Edit", forState: UIControlState.Normal)
            editBtn.enabled = true
        } else {
            editBtn.enabled = false
            editBtn.setTitle("Log in First!", forState: UIControlState.Normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func profileEdit(sender: UIButton) {
        let firstName:NSString = firstNameTF.text!
        let lastName:NSString = lastNameTF.text!
        let university:NSString = universityTF.text!
        let faculty:NSString = facultyTF.text!
        let phone:NSString = phoneTF.text!
        let whatsapp:NSString = whatsappTF.text!
    
        do {
            let post:NSString = "firstname=\(firstName)&lastname=\(lastName)&university=\(university)&faculty=\(faculty)&phone=\(phone)&whatsapp=\(whatsapp)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string: "https://afternoon-sands-99165.herokuapp.com/edit.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String(postData.length)
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            }
            catch let error as NSError {
                reponseError = error
                urlData = nil
            }
            
            if (urlData != nil) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    //var error: NSError?
                    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                    NSLog("Success: %ld", success);
                    
                    if(success == 1) {
                        NSLog("Edit success");
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else {
                        var error_msg:NSString
                        
                        if (jsonData["error_message"] as? NSString != nil) {
                            error_msg = jsonData["error_message"] as! NSString
                        }
                        else {
                            error_msg = "Unknown error"
                        }
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Edit failed!"
                        alertView.message = error_msg as String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                }
                else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Edit failed!"
                    alertView.message = "Connection failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }
            else {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Edit failed!"
                alertView.message = "Connection failed"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
        catch {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Edit failed!"
            alertView.message = "Server error!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        
    }
    
    @IBAction func pageBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
}
