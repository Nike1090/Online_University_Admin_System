//
//  UpdateCollegeViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class UpdateCollegeViewController: UIViewController {

    @IBOutlet private var collegeIdField: UITextField!
    @IBOutlet private var collegeNameField: UITextField!
    @IBOutlet private var collegeAddressField: UITextField!

    @IBAction func fetchCollege(_ sender: UIButton) {
        // Get the college ID from the text field
        guard let collegeIdText = collegeIdField.text, let collegeId = Int(collegeIdText) else {
            showAlert(message: "Invalid input. Please enter a valid integer for College ID.")
            return
        }

        
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all colleges from the database
            let allColleges = dbManager.retrieveColleges()

            // Find the college with the provided ID
            if let college = allColleges.first(where: { $0.college_Id == collegeId }) {
                collegeNameField.text = college.name
                collegeAddressField.text = college.address
            } else {
                showAlert(message: "College with ID \(collegeId) not found.")
            }
        
    }

    @IBAction func updateCollege(_ sender: UIButton) {
        // Get the college ID, name, and address from the text fields
        guard let collegeIdText = collegeIdField.text, let collegeId = Int(collegeIdText), !collegeNameField.text!.isEmpty, !collegeAddressField.text!.isEmpty else {
            showAlert(message: "Invalid input. Please fill all fields.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all colleges from the database
            let allColleges = dbManager.retrieveColleges()

            // Find the index of the college with the provided ID
            if let index = allColleges.firstIndex(where: { $0.college_Id == collegeId }) {
                // Update the college in the database
                try dbManager.db?.run("UPDATE colleges SET name = ?, address = ? WHERE college_Id = ?", collegeNameField.text!, collegeAddressField.text!, collegeId)

                showAlert(message: "College updated successfully!")
            } else {
                showAlert(message: "College with ID \(collegeId) not found.")
            }
        } catch {
            print("Error updating college: \(error)")
            showAlert(message: "Error updating college. Please try again.")
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
