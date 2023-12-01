//
//  CollegesAddViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/18/23.
//

import UIKit
import SQLite

class CollegesAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collegeId: UITextField!
    @IBOutlet weak var collegeName: UITextField!
    @IBOutlet weak var collegeAddress: UITextField!
    @IBOutlet weak var collegeImage: UIImageView!
   

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if let defaultImage = UIImage(named: "c1") { // Replace "defaultImage" with your asset image name
                    collegeImage.image = defaultImage
                }
        
    }

    @IBAction func pickImage(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func addCollege(_ sender: Any) {
        guard let clgIdText = collegeId.text,
              let clgId = Int(clgIdText),
              let clgName = collegeName.text, !clgName.isEmpty,
              let clgAddress = collegeAddress.text, !clgAddress.isEmpty,
              let clgImage = collegeImage.image else {
            showAlert(message: "Fill all fields and provide a valid image.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all colleges from the database
            let allColleges = dbManager.retrieveColleges()

            // Check if the college ID already exists in the retrieved colleges
            if allColleges.contains(where: { $0.college_Id == clgId }) {
                showAlert(message: "College with ID \(clgId) already exists. Please choose a different ID.")
            } else {
                var clgImageData: Data?

                if let imageData = clgImage.jpegData(compressionQuality: 0.5) {
                    clgImageData = imageData
                } else {
                    showAlert(message: "Error converting image.")
                    return
                }

                // Insert a new college into the database with image
                try dbManager.insertCollege(collegeId: clgId, name: clgName, address: clgAddress, imageData: clgImageData)

                showAlert(message: "\(clgName) added successfully!")

                
            }
        } catch {
            print("Error adding college: \(error)")
            showAlert(message: "Error adding college. Please try again.")
        }
    }


    // Function to display an alert with a custom message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    // Delegate method to handle image selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            collegeImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
