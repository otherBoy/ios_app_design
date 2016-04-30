//
//  SignInViewController.swift
//  course_material_app
//
//  Created by Robert Wei on 27/4/2016.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!

    @IBOutlet var loginBtn: UIButton!

    
    @IBAction func signIn(sender: UIButton) {
        let email:NSString = emailTF.text!
        let password:NSString = passwordTF.text!
        
        // email and pasword cannot be empty
        if (email.isEqualToString("") || password.isEqualToString("")) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in failed!"
            alertView.message = "Please enter your email and password."
            alertView.addButtonWithTitle("OK")
            alertView.delegate = self
            alertView.show()
        }
        else {
            let post:NSString = "email=\(email)&password=\(password)"
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            let postLength:NSString = String(postData.length)
            let url:NSURL = NSURL(string: "http://course-meterial.com/login.php")!
            //NSLog("PostData: %@",post);
        
            let request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.timeoutInterval = 10.0
        
            var urlData:NSData?
            var response: NSURLResponse?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            }
            catch (let error) {
                print(error)
            }
            if (urlData != nil) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    do {
                        if let jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options:[]) as? NSDictionary {
                            print(jsonData)
                            let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                            //[jsonData[@"success"] integerValue];
                    
                            NSLog("Success: %ld", success);
                    
                            if(success == 1) {
                                NSLog("Login success");
                        
                                var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                                prefs.setObject(email, forKey: "EMAIL")
                                prefs.setInteger(1, forKey: "ISLOGGEDIN")
                                prefs.synchronize()
                        
                                self.dismissViewControllerAnimated(true, completion: nil)
                            }
                            else {
                                let alertView = UIAlertView()
                                alertView.title = "Sign in Failed!"
                                //alertView.message = error_msg as String
                                alertView.delegate = self
                                alertView.addButtonWithTitle("OK")
                                alertView.show()
                            }

                        }
                    }
                    catch let error as NSError {
                            print(error.localizedDescription)
                    }
                    
                }
                else {
                    let alertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }
            else {
                let alertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}