//
//  SignUpViewController.swift
//  course_material_app
//
//  Created by Robert Wei on 4/21/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var confirmPasswordTF: UITextField!
    @IBOutlet var firstNameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var universityTF: UITextField!
    @IBOutlet var facultyTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var whatsappTF: UITextField!
    
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func signUp(sender: UIButton) {
        let email:NSString = emailTF.text!
        let password:NSString = passwordTF.text!
        let confirmPassword:NSString = confirmPasswordTF.text!
        let firstName:NSString = firstNameTF.text!
        let lastName:NSString = lastNameTF.text!
        let university:NSString = universityTF.text!
        let faculty:NSString = facultyTF.text!
        let phone:NSString = phoneTF.text!
        let whatsapp:NSString = whatsappTF.text!
        
        if (email.isEqualToString("") || password.isEqualToString("")
            || confirmPassword.isEqualToString("")) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign up failed!"
            alertView.message = "Email or password cannot be empty."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else if (!password.isEqual(confirmPassword)) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign up failed!"
            alertView.message = "Passwords are inconsistent."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else {
            do {
                let post:NSString = "email=\(email)&password=\(password)&firstname=\(firstName)&lastname=\(lastName)&university=\(university)&faculty=\(faculty)&phone=\(phone)&whatsapp=\(whatsapp)"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string: "https://afternoon-sands-99165.herokuapp.com/signup.php")!
                
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
                            NSLog("Sign up success");
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
                            alertView.title = "Sign up failed!"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                        }
                    }
                    else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign up failed!"
                        alertView.message = "Connection failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                }
                else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign up failed!"
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
                alertView.title = "Sign up failed!"
                alertView.message = "Server error!"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
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
