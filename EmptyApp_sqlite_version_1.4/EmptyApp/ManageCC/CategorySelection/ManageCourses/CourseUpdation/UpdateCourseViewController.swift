//
//  UpdateCourseViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class UpdateCourseViewController: UIViewController {
    var selectedCategory: Course_Category?
    @IBOutlet private var courseIdField: UITextField?
    @IBOutlet private var courseNameField: UITextField?
    @IBOutlet private var collegeIdField: UITextField?
    @IBOutlet private var programIdField: UITextField?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fetchCourseBtn(_ sender: UIButton) {
            if let courseIdText = courseIdField?.text, !courseIdText.isEmpty, let courseId = Int(courseIdText) {

                // Retrieve all courses from the database
                let allCourses = DatabaseManager.shared.retrieveCourses()

                // Fetch courses such that course's categoryid is associated with categoryid of coursecategories
                if let course = allCourses.first(where: { $0.course_Id == courseId && $0.category_Id == selectedCategory?.category_Id }) {
                    // Course found in the selected category, populate fields
                    courseNameField?.text = course.name
                    collegeIdField?.text = String(course.college_Id)
                    programIdField?.text = String(course.program_Id)
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
           let programIdText = programIdField?.text, !programIdText.isEmpty {

            if let courseId = Int(courseIdText), let collegeId = Int(collegeIdText),
               let programId = Int(programIdText) {

                // Retrieve all programs from the database
                let allPrograms = DatabaseManager.shared.retrievePrograms()
                let allColleges = DatabaseManager.shared.retrieveColleges()
                if let selectedCategory = selectedCategory {

                    

                    // Check if the specified program ID exists
                    if allPrograms.contains(where: { $0.program_Id == programId }) {
                        // Check if the specified college ID exists
                        if !allColleges.contains(where: { $0.college_Id == collegeId }) {
                            showAlert(title: "Error", message: "Invalid College ID. Please choose a valid College ID.")
                        } else {
                            // Update course details using DatabaseManager
                            do {
                                try DatabaseManager.shared.db?.run("UPDATE courses SET name = ?, college_Id = ?, program_Id = ?, category_Id = ? WHERE course_Id = ?", courseName, collegeId, programId, selectedCategory.category_Id, courseId)

                                showAlert(title: "Success", message: "Course updated successfully!")
                            } catch {
                                print("Error updating course: \(error)")
                                showAlert(title: "Error", message: "Error updating course. Please try again.")
                            }
                        }
                    } else {
                        showAlert(title: "Error", message: "Invalid Program ID. Please choose a valid Program ID.")
                    }
                } else {
                    showAlert(title: "Error", message: "Course with ID \(courseId) not found in the selected category.")
                }
            } else {
                showAlert(title: "Error", message: "Invalid input. Please enter valid Course, College, and Program IDs.")
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
