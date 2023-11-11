//
//  DeleteCollegeViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class DeleteCollegeViewController: UIViewController {
    @IBOutlet private var collegeIdField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func deleteCollege(_ sender: UIButton) {
        // Get the college ID from the text field
        guard let collegeIdText = collegeIdField.text, let collegeId = Int(collegeIdText) else {
            showAlert(message: "Invalid input. Please enter a valid integer for College ID.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all colleges from the database
            let allColleges = dbManager.retrieveColleges()

            // Find the index of the college with the provided ID
            if let index = allColleges.firstIndex(where: { $0.college_Id == collegeId }) {
                let college = allColleges[index]

                // Retrieve programs associated with the college
                let programs = dbManager.retrievePrograms().filter { $0.college_Id == college.college_Id }

                // Check if the college has programs
                if programs.isEmpty {
                    // Delete the college
                    try dbManager.db?.run("DELETE FROM colleges WHERE college_Id = ?", collegeId)
                    showAlert(message: "College deleted successfully!")
                } else {
                    showAlert(message: "Cannot delete a college with programs. Please delete the programs first.")
                }
            } else {
                showAlert(message: "College with ID \(collegeId) not found.")
            }
        } catch {
            print("Error deleting college: \(error)")
            showAlert(message: "Error deleting college. Please try again.")
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
