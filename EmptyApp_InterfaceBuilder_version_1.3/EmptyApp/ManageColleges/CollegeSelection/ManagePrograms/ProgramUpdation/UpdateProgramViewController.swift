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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fetchProgramBtn(_ sender: UIButton) {
        if let programIdText = programIdField?.text, !programIdText.isEmpty, let programId = Int(programIdText) {
            if let program = selectedCollege?.programs.first(where: { $0.program_Id == programId }) {
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
                if let selectedCollege = selectedCollege,
                   let programIndex = selectedCollege.programs.firstIndex(where: { $0.program_Id == programId }) {
                    
                    // Update the program's details
                    selectedCollege.programs[programIndex].name = programName
                    selectedCollege.programs[programIndex].college_Id = collegeId
                    
                    if let masterProgramIndex = DataModel.shared.MasterOrderProgramsList.firstIndex(where: { $0.program_Id == programId }) {
                                        DataModel.shared.MasterOrderProgramsList[masterProgramIndex] = selectedCollege.programs[programIndex]
                                    }
                    
                    showAlert(title: "Success", message: "Program updated successfully!")
                } else {
                    showAlert(title: "Error", message: "Program with ID \(programId) not found in the selected college.")
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

