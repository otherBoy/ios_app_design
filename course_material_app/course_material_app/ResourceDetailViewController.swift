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
    
    
    

    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
