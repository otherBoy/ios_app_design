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
    var courseCode : String
    var preferContact : String?
    var type : String
    var addDate : NSDate?
    var exchange : String?
    
    init(title: String, description: String, price: Float, type: String, image: String?, courseCode: String, preferContact: String?, exchange: String?, addDate: NSDate? ) {
        self.title = title
        self.description = description
        self.price = price
        self.type = type
        self.courseCode = courseCode
        self.addDate = addDate
        self.exchange = exchange
        
        if let image = image {
            self.image = image
        }
        
        if let preferContact = preferContact {
            self.preferContact = preferContact
        }
    }
    

}