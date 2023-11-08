//
//  SelectCollegeViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class SelectedCollegeViewController: UIViewController {
    var selectedCollege: College?
    @IBOutlet private var resultLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func AddProgramView(_ sender: UIButton) {
        let addProgramViewController = AddProgramViewController(nibName: "AddProgramView", bundle: nil)
        navigationController?.pushViewController(addProgramViewController, animated: true)
        addProgramViewController.selectedCollege = selectedCollege
    }
    
    @IBAction func UpdateProgramView(_ sender: UIButton) {
        let updateProgramViewController = UpdateProgramViewController(nibName: "UpdateProgramView", bundle: nil)
        navigationController?.pushViewController(updateProgramViewController, animated: true)
        updateProgramViewController.selectedCollege = selectedCollege
    }
    
    @IBAction func DeleteProgramView(_ sender: UIButton) {
        let deleteProgramViewController = DeleteProgramViewController(nibName: "DeleteProgramView", bundle: nil)
        navigationController?.pushViewController(deleteProgramViewController, animated: true)
        deleteProgramViewController.selectedCollege = selectedCollege
    }
    
    @IBAction func DisplayProgramView(_ sender: UIButton) {
            // Check if a college is selected
            guard let selectedCollege = selectedCollege else {
                resultLabel?.text = "No college selected."
                return
            }
            
            var ProgramsInfo = "Programs Information:\n"

            for (index, program) in selectedCollege.programs.enumerated() {
                ProgramsInfo += "\n\(index + 1). Program ID: \(program.program_Id)\nName: \(program.name)\nCollege ID: \(program.college_Id)\n"
            }

            // Update the resultLabel text to display program information
            resultLabel?.text = ProgramsInfo
        }


}
