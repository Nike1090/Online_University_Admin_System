//
//  CoursesAddViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar  on 11/20/23.
//

import UIKit

import UIKit

class CoursesAddViewController: UIViewController {

    @IBOutlet weak var courseId: UITextField!
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var collegeId: UITextField!
    @IBOutlet weak var programId: UITextField!
    @IBOutlet weak var categoryId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCourse(_ sender: Any) {
        guard let crsIdText = courseId.text,
              let crsId = Int(crsIdText),
              let crsName = courseName.text, !crsName.isEmpty,
              let clgIdText = collegeId.text,
              let clgId = Int(clgIdText),
              let progIdText = programId.text,
              let progId = Int(progIdText),
              let catIdText = categoryId.text,
              let catId = Int(catIdText),
              !clgIdText.isEmpty,
              !progIdText.isEmpty,
              !catIdText.isEmpty else {
            showAlert(message: "Fill all fields and provide valid IDs.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all colleges, programs, and categories from the database
            let allColleges = dbManager.retrieveColleges()
            let allPrograms = dbManager.retrievePrograms()
            let allCategories = dbManager.retrieveCourseCategories()

            // Check if the provided IDs exist in respective tables
            if allColleges.contains(where: { $0.college_Id == clgId }) &&
               allPrograms.contains(where: { $0.program_Id == progId }) &&
               allCategories.contains(where: { $0.category_Id == catId }) {

                // Insert the new course using the provided IDs into the courses table
                try dbManager.db?.run("INSERT INTO courses (course_Id, name, college_Id, program_Id, category_Id) VALUES (?, ?, ?, ?, ?)", crsId, crsName, clgId, progId, catId)

                showAlert(message: "Course added successfully!")
            } else {
                showAlert(message: "Use only existing IDs for college, program, and category.")
            }
        } catch {
            print("Error adding course: \(error)")
            showAlert(message: "Error adding course. Please try again.")
        }
    }

    // Function to display an alert with a custom message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
