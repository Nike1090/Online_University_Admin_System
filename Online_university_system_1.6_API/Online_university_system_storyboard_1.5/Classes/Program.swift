//
//  Program.swift
//  EmptyApp
//
//  Created by Nikihl kumar on 10/28/23.
//  Copyright © 2023 rab. All rights reserved.
//

import Foundation

// Class to represent Program
class Program {
    var program_Id: Int
    var name: String
    var college_Id: Int
    
    init(program_Id: Int, name: String, college_Id: Int) {
        self.program_Id = program_Id
        self.name = name
        self.college_Id = college_Id
    }
}
