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
        label.text = "Name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/dd/yyyy"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    enum EmployeeType2: String {
        case Executive
        case SeniorManagement = "Senior Management"
        case Staff
    }

    
    let employeeTypeSegmentedControl: UISegmentedControl = {
        let types = [
            EmployeeType.Executive.rawValue,
            EmployeeType.SeniorManagement.rawValue,
            EmployeeType.Staff.rawValue
        ]
        let sc = UISegmentedControl(items: types)
        sc.tintColor = UIColor.darkBlue
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private func setupUI(){
        let blueView = setupLightBlueBackgroundView(height: 160)
        [nameLabel, nameTextField, birthdayLabel, birthdayTextField, employeeTypeSegmentedControl].forEach{blueView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            birthdayLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            birthdayLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            birthdayLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            
            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.topAnchor),
            birthdayTextField.bottomAnchor.constraint(equalTo: birthdayLabel.bottomAnchor),
            birthdayTextField.leadingAnchor.constraint(equalTo: birthdayLabel.trailingAnchor, constant: 10),
            birthdayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            employeeTypeSegmentedControl.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 5),
            employeeTypeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            employeeTypeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Employee"
        view.backgroundColor = UIColor.yellow
        setupCancelButtonInNavBar()
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSaveEmployee))
    }
    
    @objc private func handleSaveEmployee(){
        var currentEmployee: Employee?
        var currentError: Error?
        
        guard let name = nameTextField.text, let currentCompany = company, let birthdayText = birthdayTextField.text  else {return}
        if birthdayText.isEmpty {
            addAction(title: "Missing Entry", message: "Please enter a birthday")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
//        let birthdayDate = dateFormatter.date(from: birthdayText) ?? Date()
        guard let birthdayDate = dateFormatter.date(from: birthdayText) else {
            addAction(title: "Invalid Entry", message: "Please enter date with format: MM/dd/yyyy")
            return
        }
        
        
        guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else {return}
//        print("\n\n==  Employee Type = \(employeeType)")
        
        (currentEmployee, currentError) = CoreDataManager.shared.createEmployee(name: name, type: employeeType, birthdayDate: birthdayDate, company: currentCompany)
        
        if let error = currentError {
            print("Error saving employee: \(error)")
            dismiss(animated: true, completion: nil)
        } else if let employee = currentEmployee {
            dismiss(animated: true, completion: {
                self.delegate?.didAddEmployee(employee: employee)
            })
        }
    }
    
    private func addAction(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
        return
    }
    
    
}
