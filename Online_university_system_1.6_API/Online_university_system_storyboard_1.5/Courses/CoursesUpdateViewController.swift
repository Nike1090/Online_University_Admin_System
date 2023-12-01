//
//  CoursesUpdateViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/20/23.
//

import UIKit

class CoursesUpdateViewController: UIViewController {

    var courseIdInt: Int?
    var courseNameText: String?
    var collegeIdInt: Int?
    var programIdInt: Int?
    var categoryIdInt: Int?
    
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var collegeId: UITextField!
    @IBOutlet weak var programId: UITextField!
    @IBOutlet weak var categoryId: UITextField!
    
    let dbManager = DatabaseManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let courseNameText = courseNameText,
           let collegeIdInt = collegeIdInt,
           let programIdInt = programIdInt,
           let categoryIdInt = categoryIdInt {
            courseName.text = courseNameText
            collegeId.text = String(collegeIdInt)
            programId.text = String(programIdInt)
            categoryId.text = String(categoryIdInt)
        }
    }
    
    @IBAction func updateCourse(_ sender: Any) {
        guard let courseId = courseIdInt,
              let courseName = courseName.text,
              let collegeIdString = collegeId.text,
              let collegeId = Int(collegeIdString),
              let programIdString = programId.text,
              let programId = Int(programIdString),
              let categoryIdString = categoryId.text,
              let categoryId = Int(categoryIdString),
              !courseName.isEmpty,
              !collegeIdString.isEmpty,
              !programIdString.isEmpty,
              !categoryIdString.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all required fields.")
            return
        }
        
        let allColleges = dbManager.retrieveColleges()
        let allPrograms = dbManager.retrievePrograms()
        let allCategories = dbManager.retrieveCourseCategories()
        
        // Check if the specified college, program, and category IDs exist
        if allColleges.contains(where: { $0.college_Id == collegeId }) &&
           allPrograms.contains(where: { $0.program_Id == programId }) &&
           allCategories.contains(where: { $0.category_Id == categoryId }) {
            // Update the course using DatabaseManager
            do {
                try dbManager.db?.run("UPDATE courses SET name = ?, college_Id = ?, program_Id = ?, category_Id = ? WHERE course_Id = ?", courseName, collegeId, programId, categoryId, courseId)
                showAlert(title: "Success", message: "Course updated successfully!")
            } catch {
                print("Error updating course: \(error)")
                showAlert(title: "Error", message: "Error updating course. Please try again.")
            }
        } else {
            showAlert(title: "Error", message: "Invalid IDs provided. Use only existing IDs.")
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
