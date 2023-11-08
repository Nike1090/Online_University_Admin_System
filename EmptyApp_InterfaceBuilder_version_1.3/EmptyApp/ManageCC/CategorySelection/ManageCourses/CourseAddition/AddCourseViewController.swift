//
//  AddCourseViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit
class AddCourseViewController: UIViewController {
    var selectedCategory: Course_Category?
    @IBOutlet private var courseIdField: UITextField?
    @IBOutlet private var courseNameField: UITextField?
    @IBOutlet private var collegeIdField: UITextField?
    @IBOutlet private var programIdField: UITextField?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addCourseBtn(_ sender: UIButton) {
        if let courseId = courseIdField?.text, !courseId.isEmpty,
           let courseName = courseNameField?.text, !courseName.isEmpty {
            
            if let selectedCategory = selectedCategory,
               let courseIdInt = Int(courseId) {
                // Check if the course ID is unique in the selected category
                if !selectedCategory.courses.contains(where: { $0.course_Id == courseIdInt }) {
                    if let collegeIdText = collegeIdField?.text, let collegeId = Int(collegeIdText),
                       let programIdText = programIdField?.text, let programId = Int(programIdText) {
                        if let college = DataModel.shared.colleges.first(where: { $0.college_Id == collegeId }),
                           college.programs.contains(where: { $0.program_Id == programId }) {
                            // Set the course_Id of the newCourse to the selected category's ID
                            let newCourse = Course(course_Id: courseIdInt, name: courseName, college_Id: collegeId, program_Id: programId, category_Id: selectedCategory.category_Id)
                            selectedCategory.courses.append(newCourse)
                            DataModel.shared.MasterOrderCourseList.append(newCourse)
                            showAlert(withTitle: "Success", message: "\(courseName) added to \(selectedCategory.name) successfully!")
                        } else {
                            showAlert(withTitle: "Error", message: "College or program with specified IDs does not exist.")
                        }
                    } else {
                        showAlert(withTitle: "Error", message: "Please provide valid college and program IDs.")
                    }
                } else {
                    showAlert(withTitle: "Error", message: "Course with ID \(courseId) already exists in \(selectedCategory.name). Please choose a different ID.")
                }
            } else {
                showAlert(withTitle: "Error", message: "Invalid selection or missing data.")
            }
        } else {
            showAlert(withTitle: "Error", message: "Please fill out all fields.")
        }
    }


    // Helper method to display alerts
    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }


}
