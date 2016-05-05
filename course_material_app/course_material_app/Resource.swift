    //
//  Resource.swift
//  course_material_app
//
//  Created by MIRKO on 4/26/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation
import UIKit

class Resource {
    var description : String
    var title : String
    var image : String?
    var price : Float
    var courseCode : String?
    var preferContact : Int?
    var type : String
    var addDate : NSDate?
    var exchange : String?
    var owner : Int
    
//    init(title: String, description: String, price: Float, type: String, image: String?, courseCode: String?, preferContact: Int?, exchange: String?, addDate: NSDate? ) {
//        self.title = title
//        self.description = description
//        self.price = price
//        self.type = type
//        self.courseCode = courseCode
//        self.addDate = addDate
//        self.exchange = exchange
//        
//        if let image = image {
//            self.image = image
//        }
//        
//        if let preferContact = preferContact {
//            self.preferContact = preferContact
//        }
//    }
    
    init(dictionary: [String : AnyObject]) {
        

        // Dictionary
        title = dictionary["TITLE"] as! String
        description = dictionary["DESCRIPTION"] as! String
        image = "default"
        price = (dictionary["PRICE"]?.floatValue)!
        courseCode = dictionary["COURSE_CODE"] as? String
        preferContact = dictionary["PREFER_CONTACT"] as? Int
        exchange = dictionary["EXCHANGE"] as? String
        type = dictionary["TYPE"] as! String
        owner = dictionary["USER_ID"] as! Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = dictionary["POSTED_DATE"] as! String
        addDate = formatter.dateFromString(date)
        
    }
    
    
    

}