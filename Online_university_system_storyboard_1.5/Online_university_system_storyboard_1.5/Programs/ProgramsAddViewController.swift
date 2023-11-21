//
//  ProgramsAddViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar  on 11/20/23.
//

import UIKit

class ProgramsAddViewController: UIViewController {

    @IBOutlet weak var programId: UITextField!
    @IBOutlet weak var programName: UITextField!
    @IBOutlet weak var collegeId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addProgram(_ sender: Any) {
        guard let progIdText = programId.text,
              let progId = Int(progIdText),
              let progName = programName.text, !progName.isEmpty,
              let clgIdText = collegeId.text,
              let clgId = Int(clgIdText),
              !clgIdText.isEmpty else {
            showAlert(message: "Fill all fields and provide a valid program ID and college ID.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all programs from the database
            let allPrograms = dbManager.retrievePrograms()

            // Check if the program ID already exists in the retrieved programs
            if allPrograms.contains(where: { $0.program_Id == progId }) {
                showAlert(message: "Program ID \(progId) already exists. Please choose a different ID.")
            } else {
                // Retrieve all colleges from the database
                let allColleges = dbManager.retrieveColleges()

                // Check if the college ID exists in the retrieved colleges
                if allColleges.contains(where: { $0.college_Id == clgId }) {
                    try dbManager.db?.run("INSERT INTO programs (program_Id, name, college_Id) VALUES (?, ?, ?)", progId, progName, clgId)
                    showAlert(message: "Program added successfully!")
                } else {
                    // College ID doesn't exist, display an alert
                    showAlert(message: "Use only existing college IDs.")
                }
            }
        } catch {
            print("Error adding program: \(error)")
            showAlert(message: "Error adding program. Please try again.")
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
