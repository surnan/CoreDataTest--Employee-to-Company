//
//  CreateEmployeeController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CreateEmployeeController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Employee"
        view.backgroundColor = UIColor.yellow
        setupCancelButtonInNavBar()
        _ = setupLightBlueBackgroundView(height: 200)
    }
}
