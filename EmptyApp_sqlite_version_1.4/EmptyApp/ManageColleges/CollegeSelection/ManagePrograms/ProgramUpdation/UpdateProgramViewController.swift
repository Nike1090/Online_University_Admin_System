//
//  UpdateProgramViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class UpdateProgramViewController: UIViewController {
    @IBOutlet private var programIdField: UITextField?
    @IBOutlet private var programNameField: UITextField?
    @IBOutlet private var collegeIdField: UITextField?
    var selectedCollege: College?

    // Access the shared instance of DatabaseManager
    let dbManager = DatabaseManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fetchProgramBtn(_ sender: UIButton) {
            if let programIdText = programIdField?.text, !programIdText.isEmpty, let programId = Int(programIdText) {
                
                // Retrieve all programs from the database
                let allPrograms = dbManager.retrievePrograms()
                
                // Fetch program such that program's collegeid is associated with collegeid of colleges
                if let program = allPrograms.first(where: { $0.program_Id == programId && $0.college_Id == selectedCollege?.college_Id }) {
                    // Program found in the selected college, populate fields
                    programNameField?.text = program.name
                    collegeIdField?.text = "\(program.college_Id)"
                } else {
                    showAlert(title: "Error", message: "Program with ID \(programId) not found in the selected college.")
                }
            } else {
                showAlert(title: "Error", message: "Invalid Program ID. Please enter a valid integer.")
            }
        }

    @IBAction func updateProgramBtn(_ sender: UIButton) {
            if let programIdText = programIdField?.text, !programIdText.isEmpty,
               let programName = programNameField?.text, !programName.isEmpty,
               let collegeIdText = collegeIdField?.text, !collegeIdText.isEmpty {
                
                if let programId = Int(programIdText), let collegeId = Int(collegeIdText) {
                    
                    // Retrieve all colleges from the database
                    let allColleges = dbManager.retrieveColleges()
                    
                    // Check if the specified college ID exists
                    if allColleges.contains(where: { $0.college_Id == collegeId }) {
                        // Update the program using DatabaseManager
                        do {
                            try dbManager.db?.run("UPDATE programs SET name = ?, college_Id = ? WHERE program_Id = ?", programName, collegeId, programId)
                            
                            showAlert(title: "Success", message: "Program updated successfully!")
                        } catch {
                            print("Error updating program: \(error)")
                            showAlert(title: "Error", message: "Error updating program. Please try again.")
                        }
                        
                    } else {
                        showAlert(title: "Error", message: "College with ID \(collegeId) not found.")
                    }
                    
                } else {
                    showAlert(title: "Error", message: "Invalid Program ID or College ID. Please enter valid integers.")
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
