//
//  DeleteProgramViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class DeleteProgramViewController: UIViewController {
    @IBOutlet private var programIdField: UITextField?
    var selectedCollege: College?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func DeleteProgramBtn(_ sender: UIButton) {
        if let programIdField = programIdField, let programIdText = programIdField.text, !programIdText.isEmpty {
            if let programId = Int(programIdText) {
                do {
                    // Access the shared instance of DatabaseManager
                    let dbManager = DatabaseManager.shared

                    // Retrieve programs from the database
                    let programs = dbManager.retrievePrograms()

                    // Check if the program with the specified ID exists
                    if programs.contains(where: { $0.program_Id == programId }) {
                        // Delete the program from the database
                        try dbManager.db?.run("DELETE FROM programs WHERE program_Id = ?", programId)

                        showAlert(message: "Program with ID \(programId) has been deleted.")
                    } else {
                        showAlert(message: "Program with ID \(programId) does not exist.")
                    }
                } catch {
                    print("Error deleting program: \(error)")
                    showAlert(message: "Error deleting program. Please try again.")
                }
            } else {
                showAlert(message: "Invalid program ID. Please enter a valid integer.")
            }
        } else {
            showAlert(message: "Please fill out the program ID field.")
        }
    }

    // Function to display an alert with a given message
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
