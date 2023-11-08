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
                // Check if the selectedCollege is not nil
                guard let selectedCollege = selectedCollege else {
                    showAlert(message: "Selected college is missing.")
                    return
                }

                // Check if the program exists in the selected college
                if let programIndex = selectedCollege.programs.firstIndex(where: { $0.program_Id == programId }) {
                    // Get the program to be deleted
                    let deletedProgram = selectedCollege.programs.remove(at: programIndex)

                    // Remove the program from the MasterOrderProgramsList
                    if let masterOrderProgramIndex = DataModel.shared.MasterOrderProgramsList.firstIndex(where: { $0.program_Id == programId }) {
                        DataModel.shared.MasterOrderProgramsList.remove(at: masterOrderProgramIndex)
                    }

                    showAlert(message: "\(deletedProgram.name) program has been deleted.")
                } else {
                    showAlert(message: "Program with ID \(programId) does not exist in the selected college.")
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

