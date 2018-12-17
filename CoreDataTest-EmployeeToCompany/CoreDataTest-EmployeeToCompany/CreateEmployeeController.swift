//
//  CreateEmployeeController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CreateEmployeeController:UIViewController {
    
    var delegate: CreateEmployeeControllerDelegate?
    var company: Company?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private func setupUI(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Employee"
        view.backgroundColor = UIColor.yellow
        setupCancelButtonInNavBar()
        let blueView = setupLightBlueBackgroundView(height: 200)
        [nameLabel, nameTextField].forEach{blueView.addSubview($0)}
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSaveEmployee))
        
    }
    
    @objc private func handleSaveEmployee(){

        var currentEmployee: Employee?
        var currentError: Error?

        guard let name = nameTextField.text, let currentCompany = company  else {return}
        
        
        (currentEmployee, currentError) = CoreDataManager.shared.createEmployee(name: name, company: currentCompany)
        
        if let error = currentError {
            print("Error saving employee: \(error)")
            dismiss(animated: true, completion: nil)
        } else if let employee = currentEmployee {
            dismiss(animated: true, completion: {
                self.delegate?.didAddEmployee(employee: employee)
                })
        }
    }
}
