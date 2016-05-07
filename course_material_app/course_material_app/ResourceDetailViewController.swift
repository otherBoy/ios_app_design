//
//  ResourceDetailViewController.swift
//  course_material_app
//
//  Created by MIRKO on 4/29/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation
import UIKit

class ResourceDetailViewController: UIViewController {
    var fetchTask: NSURLSessionDataTask?
    
    
    @IBOutlet weak var contactButton: UIButton!
    
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var exchangeLabel: UILabel!

    @IBOutlet weak var titleLable: UILabel!
    var resource : Resource?
    
    var phone = ""
    var email = ""
    var whatsapp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titleLable.text = resource?.title
        priceLabel.text = "HKD "+String(resource!.price)
        descriptionText.text = resource?.description
        courseLabel.text = resource?.courseCode
        exchangeLabel.text = resource?.exchange
        
        imageView.image = UIImage(named: "default")
        
        fetchTask = Server.sharedInstance().taskForUser((resource?.owner)!) { jsonResult, error in
            if let error = error {
                print("Error searching for actors: \(error.localizedDescription)")
                return
            }
            
            if let info = jsonResult as? [[String : AnyObject]] {
                print(info)
                
                dispatch_async(dispatch_get_main_queue()) {
                    let name = info[0]["name"] as! String
                    self.postedByLabel.text = "posted by " + name
                    
                }

                if let whatsapp = info[0]["whatsapp"] as? String  {
                    self.whatsapp = whatsapp
                } else {
                    print("no whatsapp")
                    self.whatsapp = ""
                }
                
                if let email = info[0]["email"] as? String {
                    self.email = email
                } else {
                    print("no email")
                    self.email = ""
                }
                
                if let phone = info[0]["phone"] as? String {
                    self.phone = phone
                } else {
                    print("no phone")
                    self.phone = ""
                }
                
            }

            }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

    }
    
    
    @IBAction func contactAction(sender: AnyObject) {

        
        switch resource?.preferContact {
        case 1?:
            dispatch_async(dispatch_get_main_queue()) {
                self.contactButton.setTitle("email: \(self.email)", forState: UIControlState.Normal)
            }
            if let url = NSURL(string: "mailto:\(email)") {
                UIApplication.sharedApplication().openURL(url)
            }
        case 2?:
            dispatch_async(dispatch_get_main_queue()) {
                self.contactButton.setTitle("phone: \(self.phone)", forState: UIControlState.Normal)
                
            }
            if let url = NSURL(string: "tel://\(phone)") {
                UIApplication.sharedApplication().openURL(url)
            }
        case 3?:
            dispatch_async(dispatch_get_main_queue()) {
                self.contactButton.setTitle("whatsapp: \(self.whatsapp)", forState: UIControlState.Normal)
                
            }
            print("whatsapp")
        default:
            dispatch_async(dispatch_get_main_queue()) {
                self.contactButton.setTitle("email: \(self.email)", forState: UIControlState.Normal)
            }
            if let url = NSURL(string: "mailto:\(email)") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        
    }
    

    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
