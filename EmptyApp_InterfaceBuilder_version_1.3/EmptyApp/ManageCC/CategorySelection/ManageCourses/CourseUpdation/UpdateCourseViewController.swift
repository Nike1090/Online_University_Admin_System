//
//  UpdateCourseViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

import UIKit

class UpdateCourseViewController: UIViewController {
    var selectedCategory: Course_Category?
    @IBOutlet private var courseIdField: UITextField?
    @IBOutlet private var courseNameField: UITextField?
    @IBOutlet private var collegeIdField: UITextField?
    @IBOutlet private var programIdField: UITextField?
    @IBOutlet private var categoryIdField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fetchCourseBtn(_ sender: UIButton) {
        if let courseIdText = courseIdField?.text, !courseIdText.isEmpty, let courseId = Int(courseIdText) {
            if let course = selectedCategory?.courses.first(where: { $0.course_Id == courseId }) {
                // Course found in the selected category, populate fields
                courseNameField?.text = course.name
                collegeIdField?.text = String(course.college_Id)
                programIdField?.text = String(course.program_Id)
                categoryIdField?.text = String(course.category_Id)
            } else {
                showAlert(title: "Error", message: "Course with ID \(courseId) not found in the selected category.")
            }
        } else {
            showAlert(title: "Error", message: "Invalid Course ID. Please enter a valid integer.")
        }
    }

    @IBAction func updateCourseBtn(_ sender: UIButton) {
        if let courseIdText = courseIdField?.text, !courseIdText.isEmpty,
           let courseName = courseNameField?.text, !courseName.isEmpty,
           let collegeIdText = collegeIdField?.text, !collegeIdText.isEmpty,
           let programIdText = programIdField?.text, !programIdText.isEmpty,
           let categoryIdText = categoryIdField?.text, !categoryIdText.isEmpty {
            
            if let courseId = Int(courseIdText), let collegeId = Int(collegeIdText),
               let programId = Int(programIdText), let categoryId = Int(categoryIdText) {
                
                if let selectedCategory = selectedCategory,
                   let courseIndex = selectedCategory.courses.firstIndex(where: { $0.course_Id == courseId }) {
                    
                    if !DataModel.shared.categories.contains(where: { $0.category_Id == categoryId }) {
                        showAlert(title: "Error", message: "Invalid Category ID. Please choose a valid Category ID.")
                    } else if !DataModel.shared.colleges.contains(where: { $0.college_Id == collegeId }) {
                        showAlert(title: "Error", message: "Invalid College ID. Please choose a valid College ID.")
                    } else {
                        // Update course details
                        selectedCategory.courses[courseIndex].name = courseName
                        selectedCategory.courses[courseIndex].college_Id = collegeId
                        selectedCategory.courses[courseIndex].program_Id = programId
                        selectedCategory.courses[courseIndex].category_Id = categoryId
                        
                        if let masterCourseIndex = DataModel.shared.MasterOrderCourseList.firstIndex(where: { $0.course_Id == courseId }) {
                                                   DataModel.shared.MasterOrderCourseList[masterCourseIndex] = selectedCategory.courses[courseIndex]
                                               }
                        
                        showAlert(title: "Success", message: "Course updated successfully!")
                    }
                } else {
                    showAlert(title: "Error", message: "Course with ID \(courseId) not found in the selected category.")
                }
            } else {
                showAlert(title: "Error", message: "Invalid input. Please enter valid Course, College, Program, and Category IDs.")
            }
        } else {
            showAlert(title: "Error", message: "Please fill in all required fields.")
        }
    }
    
    // Helper method to display alerts
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
