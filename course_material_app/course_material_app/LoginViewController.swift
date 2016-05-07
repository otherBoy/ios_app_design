//
//  LoginViewController.swift
//  course_material_app
//
//  Created by Robert Wei on 2/5/2016.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation

import UIKit

enum LoginShowType {
    case NONE
    case USER
    case PASS
}

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var backBtn: UIButton!
    
    //the distance from left hand to head
    var offsetLeftHand:CGFloat = 60
    
    //hand pictures used for covering eyes
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    
    //normal hand pictures
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    var showType:LoginShowType = LoginShowType.NONE
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainSize = UIScreen.mainScreen().bounds.size
        
        //draw the head of owl
        let imgLogin =  UIImageView(frame:CGRectMake(mainSize.width/2-211/2, 100, 211, 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        //draw left hand (cover eyes)
        let rectLeftHand = CGRectMake(61 - offsetLeftHand, 90, 40, 65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        //draw right hand (cover eyes)
        let rectRightHand = CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        //draw the background box
        let vLogin =  UIView(frame:CGRectMake(15, 200, mainSize.width - 30, 160))
        //vLogin.layer.borderWidth = 0.5
        //vLogin.layer.borderColor = UIColor.lightGrayColor().CGColor
        vLogin.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(vLogin)
        
        //draw left hand
        let rectLeftHandGone = CGRectMake(mainSize.width / 2 - 100,
                                          vLogin.frame.origin.y - 22, 40, 40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgLeftHandGone)
        
        //draw right hand
        let rectRightHandGone = CGRectMake(mainSize.width / 2 + 62,
                                           vLogin.frame.origin.y - 22, 40, 40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgRightHandGone)
        
        //email input box
        emailTF = UITextField(frame:CGRectMake(30, 30, vLogin.frame.size.width - 60, 44))
        emailTF.delegate = self
        emailTF.layer.cornerRadius = 5
        emailTF.layer.borderColor = UIColor.lightGrayColor().CGColor
        emailTF.layer.borderWidth = 0.5
        emailTF.leftView = UIView(frame:CGRectMake(0, 0, 44, 44))
        emailTF.leftViewMode = UITextFieldViewMode.Always
        
        let imgUser =  UIImageView(frame:CGRectMake(11, 11, 22, 22))
        imgUser.image = UIImage(named:"iconfont-user")
        emailTF.leftView!.addSubview(imgUser)
        vLogin.addSubview(emailTF)
        
        //password input box
        passwordTF = UITextField(frame:CGRectMake(30, 90, vLogin.frame.size.width - 60, 44))
        passwordTF.delegate = self
        passwordTF.layer.cornerRadius = 5
        passwordTF.layer.borderColor = UIColor.lightGrayColor().CGColor
        passwordTF.layer.borderWidth = 0.5
        passwordTF.secureTextEntry = true
        passwordTF.leftView = UIView(frame:CGRectMake(0, 0, 44, 44))
        passwordTF.leftViewMode = UITextFieldViewMode.Always
        
        let imgPwd =  UIImageView(frame:CGRectMake(11, 11, 22, 22))
        imgPwd.image = UIImage(named:"iconfont-password")
        passwordTF.leftView!.addSubview(imgPwd)
        vLogin.addSubview(passwordTF)
    }
    
    //get the input box type
    func textFieldDidBeginEditing(textField:UITextField)
    {
        //select email input box
        if textField.isEqual(emailTF) {
            if (showType != LoginShowType.PASS)
            {
                showType = LoginShowType.USER
                return
            }
            showType = LoginShowType.USER
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRectMake(
                    self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
                    self.imgLeftHand.frame.origin.y + 30,
                    self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRectMake(
                    self.imgRightHand.frame.origin.x + 48,
                    self.imgRightHand.frame.origin.y + 30,
                    self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRectMake(
                    self.imgLeftHandGone.frame.origin.x - 70,
                    self.imgLeftHandGone.frame.origin.y, 40, 40)
                self.imgRightHandGone.frame = CGRectMake(
                    self.imgRightHandGone.frame.origin.x + 30,
                    self.imgRightHandGone.frame.origin.y, 40, 40)
            })
        }
        //select password input box
        else if textField.isEqual(passwordTF) {
            if (showType == LoginShowType.PASS)
            {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
            
            //cover eyes
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRectMake(
                    self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                    self.imgLeftHand.frame.origin.y - 30,
                    self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRectMake(
                    self.imgRightHand.frame.origin.x - 48,
                    self.imgRightHand.frame.origin.y - 30,
                    self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRectMake(
                    self.imgLeftHandGone.frame.origin.x + 70,
                    self.imgLeftHandGone.frame.origin.y, 0, 0)
                self.imgRightHandGone.frame = CGRectMake(
                    self.imgRightHandGone.frame.origin.x - 30,
                    self.imgRightHandGone.frame.origin.y, 0, 0)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
        let email:NSString = emailTF.text!
        let password:NSString = passwordTF.text!
        
        if (email.isEqualToString("") || password.isEqualToString("")) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Login failed!"
            alertView.message = "Please enter your email and password."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else {
            do {
                let post:NSString = "email=\(email)&password=\(password)"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string:"https://afternoon-sands-99165.herokuapp.com/login.php")!
                
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
                        
                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                        
                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        
                        //[jsonData[@"success"] integerValue];
                        
                        NSLog("Success: %ld", success);
                        
                        if(success == 1) {
                            NSLog("Login success");
                            let defaults = NSUserDefaults.standardUserDefaults()
                            defaults.setBool(true, forKey: "loggedIn")

                            
                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            prefs.setObject(email, forKey: "EMAIL")
                            prefs.setInteger(1, forKey: "ISLOGGEDIN")
                            prefs.synchronize()
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            var error_msg:NSString
                            
                            if (jsonData["error_message"] as? NSString != nil) {
                                error_msg = jsonData["error_message"] as! NSString
                            }
                            else {
                                error_msg = "Unknown error"
                            }
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Login failed!"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                        }
                    }
                    else {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Login failed!"
                        alertView.message = "Connection failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                }
                else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Login failed!"
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
                alertView.title = "Login failed!"
                alertView.message = "Server error"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
        
    }
    
    @IBAction func pageBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}
