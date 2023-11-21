//
//  UpdateCollegesViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/18/23.
//

import UIKit


class CollegesUpdateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var collegeIdInt: Int?
    var collegeNameText: String?
    var collegeAddressText: String?
    var collegeImg: UIImage?

    @IBOutlet weak var collegeName: UITextField!
    @IBOutlet weak var collegeAddress: UITextField!
    @IBOutlet weak var collegeImage: UIImageView!

    let imagePicker = UIImagePickerController()
    let dbManager = DatabaseManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self

        collegeName.text = collegeNameText
        collegeAddress.text = collegeAddressText
        collegeImage.image = collegeImg
    }

    @IBAction func pickImage(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func updateCollege(_ sender: Any) {
        guard let collegeId = collegeIdInt, let newName = collegeName.text, let newAddress = collegeAddress.text else {
            showAlert(message: "Invalid input. Please fill all fields.")
            return
        }

        do {
            let newImageData = collegeImage.image?.jpegData(compressionQuality: 0.5)
            try dbManager.updateCollege(collegeId: collegeId, newName: newName, newAddress: newAddress, newImageData: newImageData)
            showAlert(message: "College updated successfully!")
        } catch {
            print("Error updating college: \(error)")
            showAlert(message: "Error updating college. Please try again.")
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            collegeImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
