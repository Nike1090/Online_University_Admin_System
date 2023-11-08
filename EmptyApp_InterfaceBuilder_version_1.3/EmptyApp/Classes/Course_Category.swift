//
//  Course_Category.swift
//  EmptyApp
//
//  Created by Nikihl kumar on 10/28/23.
//  Copyright © 2023 rab. All rights reserved.
//

import Foundation
// Class to represent Course Category
class Course_Category {
    var category_Id: Int
    var name: String
    var courses: [Course] = []
    
    init(category_Id: Int, name: String) {
        self.category_Id = category_Id
        self.name = name
    }
}
