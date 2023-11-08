//
//  ManageCollegesViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class ManageCollegesViewController: UIViewController {
    
 
    @IBOutlet private var resultLabel: UILabel?
    @IBOutlet private var SearchCollegeField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    @IBAction func addCollegeView(_ sender: UIButton) {
        let addCollegeViewController = AddCollegeViewController(nibName: "AddCollegeView", bundle: nil)
        navigationController?.pushViewController(addCollegeViewController, animated: true)
    }
    
    @IBAction func updateCollegeView(_ sender: UIButton) {
        let updateCollegeViewController = UpdateCollegeViewController(nibName: "UpdateCollegeView", bundle: nil)
        navigationController?.pushViewController(updateCollegeViewController, animated: true)
    }
    
    @IBAction func deleteCollegeView(_ sender: UIButton) {
        let deleteCollegeViewController = DeleteCollegeViewController(nibName: "DeleteCollegeView", bundle: nil)
        navigationController?.pushViewController(deleteCollegeViewController, animated: true)
    }
    
    @IBAction func displayColleges(_ sender: UIButton) {
        // Access the DataModel singleton instance
        let dataModel = DataModel.shared

        // Retrieve the list of colleges from the data model
        let colleges = dataModel.colleges
        
        // Create a string to display college information
        var collegeInfo = "Colleges Information:\n"
        
        for (index, college) in colleges.enumerated() {
            
            collegeInfo.append("\n\(index + 1). College ID: \(college.college_Id)\nName: \(college.name)\nAddress: \(college.address)\n")
           
        }
         
        // Update the resultLabel text to display college information
        resultLabel?.text = collegeInfo
    }

    
    
    @IBAction func selectCollegeView(_ sender: UIButton) {
        // Get the entered college ID
        guard let collegeIdText = SearchCollegeField?.text, let collegeId = Int(collegeIdText) else {
            showAlert(message: "Invalid input. Please enter a valid integer for College ID.")
            return
        }

        // Access the DataModel singleton instance
        let dataModel = DataModel.shared

        // Find the selected college by ID
        if let selectedCollege = dataModel.colleges.first(where: { $0.college_Id == collegeId }) {
            // Initialize the SelectedCollegeViewController
            let selectedCollegeViewController = SelectedCollegeViewController(nibName: "SelectedCollegeView", bundle: nil)

            // Pass the selected college object to the next view controller
            selectedCollegeViewController.selectedCollege = selectedCollege

            // Navigate to the SelectedCollegeViewController
            navigationController?.pushViewController(selectedCollegeViewController, animated: true)
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
