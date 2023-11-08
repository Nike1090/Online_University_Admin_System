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
        
        // Access the DataModel singleton instance
        let dataModel = DataModel.shared

        // Find the index of the college with the provided ID
        if let index = dataModel.colleges.firstIndex(where: { $0.college_Id == collegeId }) {
            let college = dataModel.colleges[index]
            
            // Check if the college has programs
            if college.programs.isEmpty {
                // Delete the college
                dataModel.colleges.remove(at: index)
                showAlert(message: "College deleted successfully!")
            } else {
                showAlert(message: "Cannot delete a college with programs. Please delete the programs first.")
            }
        } else {
            showAlert(message: "College with ID \(collegeId) not found.")
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
