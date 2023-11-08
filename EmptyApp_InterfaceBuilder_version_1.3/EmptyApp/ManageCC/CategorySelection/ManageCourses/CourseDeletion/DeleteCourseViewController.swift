//
//  DeleteCourseViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class DeleteCourseViewController: UIViewController {
    var selectedCategory: Course_Category?
    @IBOutlet private var courseIdField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func DeleteCourseBtn(_ sender: UIButton) {
        // Error handling and course deletion logic
        if let courseIdText = courseIdField?.text, !courseIdText.isEmpty, let courseId = Int(courseIdText) {
            if let selectedCategory = selectedCategory {
                // Check if the course with the specified ID exists in the selected category
                if let courseIndex = selectedCategory.courses.firstIndex(where: { $0.course_Id == courseId }) {
                    let deletedCourse = selectedCategory.courses.remove(at: courseIndex)
                    
                    // Remove the course from the MasterOrderCourseList
                    if let masterCourseIndex = DataModel.shared.MasterOrderCourseList.firstIndex(where: { $0.course_Id == deletedCourse.course_Id }) {
                        DataModel.shared.MasterOrderCourseList.remove(at: masterCourseIndex)
                    }
                    
                    showAlert(title: "Success", message: "\(deletedCourse.name) deleted successfully.")
                } else {
                    showAlert(title: "Error", message: "Course with ID \(courseId) not found in the selected category.")
                }
            } else {
                showAlert(title: "Error", message: "No category selected.")
            }
        } else {
            showAlert(title: "Error", message: "Please enter a valid Course ID.")
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
