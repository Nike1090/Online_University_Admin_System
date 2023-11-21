//
//  Course.swift
//  EmptyApp
//
//  Created by Nikihl kumar on 10/28/23.
//  Copyright © 2023 rab. All rights reserved.
//

import Foundation
// Class to represent the Course
class Course {
    var course_Id: Int
    var name: String
    var college_Id: Int
    var program_Id: Int
    var category_Id: Int
    
    init(course_Id: Int, name: String, college_Id: Int, program_Id: Int, category_Id: Int) {
        self.course_Id = course_Id
        self.name = name
        self.college_Id = college_Id
        self.program_Id = program_Id
        self.category_Id = category_Id
    }
}
