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
    @IBOutlet weak var contactButton: UIButton!
    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var postedByLabel: UIView!
    @IBOutlet weak var titleLable: UILabel!
    var resource : Resource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titleLable.text = resource?.title
        priceLabel.text = "HKD "+String(resource!.price)
        descriptionText.text = resource?.description
        courseLabel.text = resource?.courseCode
        
        imageView.image = UIImage(named: "default")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if resource?.preferContact == "email" {
            contactButton.setTitle("email", forState: UIControlState.Normal)
        } else if resource?.preferContact == "wechat" {
            contactButton.setTitle("wechat", forState: UIControlState.Normal)
        } else if resource?.preferContact == "whatsapp" {
            contactButton.setTitle("WhatsApp", forState: UIControlState.Normal)
        } else {
            contactButton.setTitle("Phone", forState: UIControlState.Normal)
        }
    }
    
    
    @IBAction func contactAction(sender: AnyObject) {
        if resource?.preferContact == "email" {
            let email = "foo@bar.com"
            let url = NSURL(string: "mailto:\(email)")
            UIApplication.sharedApplication().openURL(url!)
        } else if resource?.preferContact == "wechat" {
            contactButton.setTitle("wechat", forState: UIControlState.Normal)
        } else if resource?.preferContact == "whatsapp" {
            contactButton.setTitle("WhatsApp", forState: UIControlState.Normal)
        } else {
            let phone = 55998380
            if let url = NSURL(string: "tel://\(phone)") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        
    }
    

    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
