//
//  CreateCompanyController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/15/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

class CreateCompanyController: UIViewController{
    
    var delegate: CreateCompanyControllerDelegate?
    var company: Company? {  //passed from editRowAction
        didSet{
            nameTextField.text = company?.name
            datePicker.date = company?.founded ?? Date()
        }
    }
    
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
    
    let datePicker: UIDatePicker = {
       let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    private func setupNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
    }
    
    
    private func setupUI(){
        let lightBlueBackGroundView = UIView();
        lightBlueBackGroundView.backgroundColor = .lightBlue
        lightBlueBackGroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBlueBackGroundView)
        [nameLabel, nameTextField, datePicker].forEach{lightBlueBackGroundView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            lightBlueBackGroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lightBlueBackGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lightBlueBackGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lightBlueBackGroundView.heightAnchor.constraint(equalToConstant: 250),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            datePicker.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: lightBlueBackGroundView.bottomAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlue
        setupNavBar()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    
    @objc private func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func CreateCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)      //"Company" <--- name of entity
        company.setValue(nameTextField.text ?? "", forKey: "name")                                      //"Name" <--- name of attribute
        company.setValue(datePicker.date, forKey: "founded")
        
        do {
            try context.save()
            self.dismiss(animated: true, completion: {
                self.delegate?.didAddCompany(company: company as! Company)
                //            let newCompany = Company(name: self.nameTextField.text ?? "", founded: Date())
                //            self.delegate?.didAddCompany(company: newCompany)
            })
        } catch let saveErr {
            print("Unable to save new company to Core Data \(saveErr)")
        }
    }
    
    @objc private func handleSave(){
        if company == nil {
            CreateCompany()
        } else {
            saveCompanyChanges()
        }
    }
    
    private func saveCompanyChanges(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        company?.name = nameTextField.text
        company?.founded = datePicker.date
        do {
            try context.save()
            dismiss(animated: true, completion:{
                self.delegate?.didEditCompany(company: self.company!)
            })
        } catch let saveErr {
            print("Unabled to save Edited Company \(saveErr)")
        }
    }
}
