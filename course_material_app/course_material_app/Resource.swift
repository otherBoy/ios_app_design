//
//  Resource.swift
//  course_material_app
//
//  Created by MIRKO on 4/26/16.
//  Copyright © 2016 hku_project. All rights reserved.
//

import Foundation

class Resource {
    var description : String?
    var title : String?
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}