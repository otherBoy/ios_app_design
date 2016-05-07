//
//  PostViewController.swift
//  course_material_app
//
//  Created by Robert Wei on 4/21/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation

import UIKit

class PostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerDataSource = ["textbook", "video", "notes", "PPT", "exampaper"]
    var selected:NSString = ""
    
    //debug
    var state:Bool = false
    enum Contact:Int {
        case onlyPhone = 1
        case onlyEmail
        case onlyWhatsapp
        case Phone_Email
        case Phone_Whatsapp
        case Email_Whatsapp
        case All
    }
    
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var descriptionTF: UITextField!
    @IBOutlet var courseCodeTF: UITextField!
    @IBOutlet var priceTF: UITextField!
    @IBOutlet var exchangeTF: UITextField!
    
    @IBOutlet var postBtn: UIButton!

    @IBOutlet var typePV: UIPickerView!
    
    @IBOutlet var phoneSwitch: UISwitch!
    @IBOutlet var emailSwitch: UISwitch!
    @IBOutlet var whatsappSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.typePV.dataSource = self;
        self.typePV.delegate = self;
        
        phoneSwitch.addTarget(self, action: #selector(PostViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        emailSwitch.addTarget(self, action: #selector(PostViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        whatsappSwitch.addTarget(self, action: #selector(PostViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("loggedIn") {
            postBtn.setTitle("Post", forState: UIControlState.Normal)
            postBtn.enabled = true
        } else {
            postBtn.enabled = false
            postBtn.setTitle("Log in First!", forState: UIControlState.Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        selected = pickerDataSource[row]
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            state = true
        }
        else {
            state = false
        }
    }
    
    @IBAction func postMaterial(sender: UIButton) {
        let title:NSString = titleTF.text!
        let description:NSString = descriptionTF.text!
        let courseCode:NSString = courseCodeTF.text!
        let exchangeFor:NSString = exchangeTF.text!
        
        let price:NSString = priceTF.text!
        let priceValue = price.floatValue
        
        let type:NSString = selected
        
        // Prefer Contact
        var preferContact:Int = 1
        let phoneState:Bool = true
        let emailState:Bool = true
        let whatsappState:Bool = true
        
        if (phoneState == true && emailState == false && whatsappState == false) {
            preferContact = 1
        }
        else if (phoneState == false && emailState == true && whatsappState == false) {
            preferContact = 2
        }
        else if (phoneState == false && emailState == false && whatsappState == true) {
            preferContact = 3
        }
        else if (phoneState == true && emailState == true && whatsappState == false) {
            preferContact = 4
        }
        else if (phoneState == true && emailState == false && whatsappState == true) {
            preferContact = 5
        }
        else if (phoneState == false && emailState == true && whatsappState == true) {
            preferContact = 6
        }
        else if (phoneState == true && emailState == true && whatsappState == true) {
            preferContact = 7
        }
        else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Post failed!"
            alertView.message = "Please choose a contact way."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }

        if (title.isEqualToString("") || courseCode.isEqualToString("")) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Post failed!"
            alertView.message = "Title or course code cannot be empty."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else {
            do {
                let post:NSString = "title=\(title)&description=\(description)&type=\(type)&code=\(courseCode)&contact=\(preferContact)&price=\(priceValue)&exchange=\(exchangeFor)"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string: "https://afternoon-sands-99165.herokuapp.com/post.php")!
                
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
                            NSLog("Post resource success");
                            self.dismissViewControllerAnimated(true, completion: nil)
                            let alertView:UIAlertView = UIAlertView()
                            alertView.message = "Post success!"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()

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
                            alertView.title = "Post failed!"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                        }
                    }
                    else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Post failed!"
                        alertView.message = "Connection failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                }
                else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Post failed!"
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
                alertView.title = "Post failed!"
                alertView.message = "Server error!"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }

    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
}

