//
//  CreateCompanyController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/15/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController{
    
    var delegate: CreateCompanyControllerDelegate?
    
    
    
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
    
    
    
    
    
    private func setupNavBar(){
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
    }
    
    private func setupUI(){
        let lightBlueBackGroundView = UIView();
        lightBlueBackGroundView.backgroundColor = .lightBlue
        lightBlueBackGroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBlueBackGroundView)
        [nameLabel, nameTextField].forEach{lightBlueBackGroundView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            lightBlueBackGroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lightBlueBackGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lightBlueBackGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lightBlueBackGroundView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
            
            
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        setupNavBar()
        setupUI()
    }
    
    
    
    
    @objc private func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSave(){
        print("SAVE SAVE SAVE")
        self.dismiss(animated: true, completion: {
            let newCompany = Company(name: self.nameTextField.text ?? "", founded: Date())
            self.delegate?.didAddCompany(company: newCompany)
        })
    }
}
