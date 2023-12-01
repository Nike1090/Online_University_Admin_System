//
//  ProgramsUpdateViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/20/23.
//

import UIKit


class ProgramsUpdateViewController: UIViewController {

    var programIdInt: Int?
    var programNameText: String?
    var collegeIdInt: Int?
    
    @IBOutlet weak var programNameTextField: UITextField!
    @IBOutlet weak var collegeIdTextField: UITextField!
    
    let dbManager = DatabaseManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let programName = programNameText, let collegeId = collegeIdInt {
            programNameTextField.text = programName
            collegeIdTextField.text = String(collegeId)
        }
    }
    
    @IBAction func updateProgramBtn(_ sender: UIButton) {
        guard let programId = programIdInt,
              let programName = programNameTextField.text,
              let collegeIdString = collegeIdTextField.text,
              let collegeId = Int(collegeIdString),
              !programName.isEmpty,
              !collegeIdString.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all required fields.")
            return
        }
        
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
            showAlert(title: "Error", message: "College with ID \(collegeId) not found. Use only existing college ids")
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
