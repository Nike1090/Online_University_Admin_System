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
            do {
                // Access the shared instance of DatabaseManager
                let dbManager = DatabaseManager.shared

                // Retrieve courses from the database
                let courses = dbManager.retrieveCourses()

                // Check if the course with the specified ID exists
                if let courseIndex = courses.firstIndex(where: { $0.course_Id == courseId }) {
                    // Delete the course from the database
                    try dbManager.db?.run("DELETE FROM courses WHERE course_Id = ?", courseId)

                    showAlert(title: "Success", message: "Course with ID \(courseId) has been deleted.")
                } else {
                    showAlert(title: "Error", message: "Course with ID \(courseId) not found.")
                }
            } catch {
                print("Error deleting course: \(error)")
                showAlert(title: "Error", message: "Error deleting course. Please try again.")
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
