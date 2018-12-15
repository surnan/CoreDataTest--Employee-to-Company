//
//  CreateCompanyController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/15/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController{
    
    
    private func setupNavBar(){
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        setupNavBar()
    }
    
    
    
    
    @objc private func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
