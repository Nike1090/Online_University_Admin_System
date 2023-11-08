//
//  SelectCategoryViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class SelectedCategoryViewController: UIViewController {
    var selectedCategory: Course_Category?
    @IBOutlet private var resultLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func AddCourseView(_ sender: UIButton) {
        let addCourseViewController = AddCourseViewController(nibName: "AddCourseView", bundle: nil)
        navigationController?.pushViewController(addCourseViewController, animated: true)
        addCourseViewController.selectedCategory = selectedCategory
    }
    
    @IBAction func UpdateCourseView(_ sender: UIButton) {
        let updateCourseViewController = UpdateCourseViewController(nibName: "UpdateCourseView", bundle: nil)
        navigationController?.pushViewController(updateCourseViewController, animated: true)
        updateCourseViewController.selectedCategory = selectedCategory
    }
    
    @IBAction func DeleteCourseView(_ sender: UIButton) {
        let deleteCourseViewController = DeleteCourseViewController(nibName: "DeleteCourseView", bundle: nil)
        navigationController?.pushViewController(deleteCourseViewController, animated: true)
        deleteCourseViewController.selectedCategory = selectedCategory
    }
    
    @IBAction func DisplayCourseView(_ sender: UIButton) {
        // Check if a category is selected
        guard let selectedCategory = selectedCategory else {
            resultLabel?.text = "No Category selected."
            return
        }
        
        var CoursesInfo = "Courses Information:\n"

        for (index, course) in selectedCategory.courses.enumerated() {
            CoursesInfo.append("\n\(index + 1). Course ID: \(course.course_Id)\nName: \(course.name)\nCollege ID: \(course.college_Id)\nProgram ID: \(course.program_Id)\nCategory ID: \(course.category_Id)\n")
        }

        // Update the resultLabel text to display course information
        resultLabel?.text = CoursesInfo

    }

    

}
