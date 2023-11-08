//
//  DataModel.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/6/23.
//  Copyright © 2023 rab. All rights reserved.
//

import Foundation
import UIKit

class DataModel {
    static let shared = DataModel()

    var colleges: [College] = []
    var categories: [Course_Category] = []
    var MasterOrderProgramsList: [Program] = []
    var MasterOrderCourseList: [Course] = []

    private init() {
        // Initializing the data here
        // Adding your data initialization code here
        // Create an initial college with some data
        // Create an initial college with some data
        let initialCollege1 = College(college_Id: 101, name: "COE", address: "150 Huntington")
        let program1 = Program(program_Id: 320, name: "CS", college_Id: initialCollege1.college_Id)
        let program2 = Program(program_Id: 321, name: "IS", college_Id: initialCollege1.college_Id)
        
        initialCollege1.programs.append(program1)
        initialCollege1.programs.append(program2)
        colleges.append(initialCollege1)
        
        MasterOrderProgramsList.append(program1)
        MasterOrderProgramsList.append(program2)
        
        
        
        let initialCollege2 = College(college_Id: 102, name: "CPS", address: "140 walter street")
        let program3 = Program(program_Id: 420, name: "DA", college_Id: initialCollege2.college_Id)
        let program4 = Program(program_Id: 421, name: "MA", college_Id: initialCollege2.college_Id)
        
        initialCollege2.programs.append(program3)
        initialCollege2.programs.append(program4)
        colleges.append(initialCollege2)
        
        MasterOrderProgramsList.append(program3)
        MasterOrderProgramsList.append(program4)
        
        // Create categories and courses with some data
        
        //category1
        let category1 = Course_Category(category_Id: 5000, name: "INFO")
        let course1 = Course(course_Id: 800, name: "Web design", college_Id: initialCollege1.college_Id, program_Id: program2.program_Id, category_Id: category1.category_Id)
        let course2 = Course(course_Id: 801, name: "mobile design", college_Id: initialCollege1.college_Id, program_Id: program2.program_Id, category_Id: category1.category_Id)
        
        categories.append(category1)
        
        category1.courses.append(course1)
        category1.courses.append(course2)
        
        //category2
        let category2 = Course_Category(category_Id: 5001, name: "CSE")
        let course3 = Course(course_Id: 802, name: "OS", college_Id: initialCollege1.college_Id, program_Id: program1.program_Id, category_Id: category2.category_Id)
        let course4 = Course(course_Id: 803, name: "networks", college_Id: initialCollege1.college_Id, program_Id: program1.program_Id, category_Id: category2.category_Id)
        
        categories.append(category2)
        
        category2.courses.append(course3)
        category2.courses.append(course4)
        
        //category3
        let category3 = Course_Category(category_Id: 5002, name: "CPSE")
        let course5 = Course(course_Id: 804, name: "data analysis", college_Id: initialCollege2.college_Id, program_Id: program3.program_Id, category_Id: category3.category_Id)
        let course6 = Course(course_Id: 805, name: "data mining", college_Id: initialCollege2.college_Id, program_Id: program3.program_Id, category_Id: category3.category_Id)
        
        categories.append(category3)
        
        category3.courses.append(course5)
        category3.courses.append(course6)
        
        //category4
        let category4 = Course_Category(category_Id: 5003, name: "CSP")
        let course7 = Course(course_Id: 806, name: "Web design", college_Id: initialCollege2.college_Id, program_Id: program4.program_Id, category_Id: category4.category_Id)
        let course8 = Course(course_Id: 807, name: "mobile design", college_Id: initialCollege2.college_Id, program_Id: program4.program_Id, category_Id: category4.category_Id)
        
        categories.append(category4)
        
        category4.courses.append(course7)
        category4.courses.append(course8)
        
        MasterOrderCourseList.append(course1)
        MasterOrderCourseList.append(course2)
        MasterOrderCourseList.append(course3)
        MasterOrderCourseList.append(course4)
        MasterOrderCourseList.append(course5)
        MasterOrderCourseList.append(course6)
        MasterOrderCourseList.append(course7)
        MasterOrderCourseList.append(course8)
    }
    
   
    
    

}
