//
//  AddCollegeViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit


class AddCollegeViewController: UIViewController {

    @IBOutlet private var clgIdField: UITextField!
    @IBOutlet private var clgNameField: UITextField!
    @IBOutlet private var clgAddressField: UITextField!

    @IBAction func addCollege(_ sender: UIButton) {
        // Get the college ID, name, and address from the text fields
        guard let clgIdText = clgIdField.text, let clgId = Int(clgIdText),
              let clgName = clgNameField.text, !clgName.isEmpty,
              let clgAddress = clgAddressField.text, !clgAddress.isEmpty else {
            showAlert(message: "Fill all fields and provide valid inputs.")
            return
        }

        // Access the DataModel singleton instance
        let dataModel = DataModel.shared

        // Check if the college ID already exists
        if dataModel.colleges.contains(where: { $0.college_Id == clgId }) {
            showAlert(message: "College with ID \(clgId) already exists. Please choose a different ID.")
        } else {
            // Create a new college and add it to the data model
            let newCollege = College(college_Id: clgId, name: clgName, address: clgAddress)
            dataModel.colleges.append(newCollege)
            showAlert(message: "\(clgName) added successfully!")
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
