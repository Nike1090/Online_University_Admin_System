//
//  AddProgramViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class AddProgramViewController: UIViewController {
    var selectedCollege: College?
    @IBOutlet private var programIdField: UITextField?
    @IBOutlet private var programNameField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addProgramBtn(_ sender: UIButton) {
        if let programId = programIdField?.text, !programId.isEmpty,
           let programName = programNameField?.text, !programName.isEmpty {
            
            if let college = selectedCollege {
                if let programIdInt = Int(programId) {
                    do {
                        // Access the shared instance of DatabaseManager
                        let dbManager = DatabaseManager.shared

                        // Retrieve all programs from the database
                        let allPrograms = dbManager.retrievePrograms()

                        // Check if the program ID is unique in the retrieved programs
                        if !allPrograms.contains(where: { $0.program_Id == programIdInt }) {
                            // Insert a new program into the database
                            try dbManager.db?.run("INSERT INTO programs (program_Id, name, college_Id) VALUES (?, ?, ?)", programIdInt, programName, college.college_Id)

                            // Display a success message
                            showAlert(withTitle: "Success", message: "\(programName) added to \(college.name) successfully!")
                        } else {
                            // Display an error message if the program ID already exists
                            showAlert(withTitle: "Error", message: "Program with ID \(programId) already exists. Please choose a different ID.")
                        }
                    } catch {
                        print("Error adding program: \(error)")
                        showAlert(withTitle: "Error", message: "Error adding program. Please try again.")
                    }
                } else {
                    // Display an error message for an invalid program ID
                    showAlert(withTitle: "Error", message: "Invalid program ID. Please enter a valid integer.")
                }
            } else {
                // Display an error message if the selected college is missing
                showAlert(withTitle: "Error", message: "Selected college is missing.")
            }
        } else {
            // Display an error message if program ID and name fields are empty
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
