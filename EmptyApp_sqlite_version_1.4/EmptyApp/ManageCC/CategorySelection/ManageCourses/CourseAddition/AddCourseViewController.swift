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

    // Access the shared instance of DatabaseManager
    let dbManager = DatabaseManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addCourseBtn(_ sender: UIButton) {
        if let courseId = courseIdField?.text, !courseId.isEmpty,
           let courseName = courseNameField?.text, !courseName.isEmpty {
            
            if let selectedCategory = selectedCategory,
               let courseIdInt = Int(courseId) {
                
                // Check if the course ID is unique in the retrieved courses
                let allCourses = dbManager.retrieveCourses()
                if allCourses.contains(where: { $0.course_Id == courseIdInt }) {
                    // Display an error message if the course ID already exists
                    showAlert(withTitle: "Error", message: "Course with ID \(courseId) already exists. Please choose a different ID.")
                    return
                }

                // Check if the user is only using collegeid, programid from retrieved colleges and programs
                if let collegeIdText = collegeIdField?.text, let collegeId = Int(collegeIdText),
                   let programIdText = programIdField?.text, let programId = Int(programIdText) {

                    // Check if the selected college and program exist
                    let allColleges = dbManager.retrieveColleges()
                    let allPrograms = dbManager.retrievePrograms()
                    if let college = allColleges.first(where: { $0.college_Id == collegeId }),
                       allPrograms.contains(where: { $0.program_Id == programId }) {

                        // Make sure selected category categoryid is inserted to courses table
                        let category_Id = selectedCategory.category_Id
                        
                        // Use DatabaseManager directly for adding the course
                        do {
                            try dbManager.db?.run("INSERT INTO courses (course_Id, name, college_Id, program_Id, category_Id) VALUES (?, ?, ?, ?, ?)", courseIdInt, courseName, collegeId, programId, category_Id)
                            showAlert(withTitle: "Success", message: "\(courseName) added to \(selectedCategory.name) successfully!")
                        } catch {
                            print("Error adding course: \(error)")
                            showAlert(withTitle: "Error", message: "Error adding course. Please try again.")
                        }
                        
                    } else {
                        showAlert(withTitle: "Error", message: "College or program with specified IDs does not exist.")
                    }
                } else {
                    showAlert(withTitle: "Error", message: "Please provide valid college and program IDs.")
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

