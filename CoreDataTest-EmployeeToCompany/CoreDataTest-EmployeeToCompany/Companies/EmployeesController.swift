//
//  EmployeesController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/17/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}


class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    
    var company: Company?
    let cellID = "asdfasdfasdf"
    var allEmployees =  [[Employee]]()
    
    let shortNameMaxLength = 4
    let mediumNameMaxLength = 6
    
    func didAddEmployee(employee: Employee) {
        guard let nameLength = employee.name?.count else {return}
        var section = 0
        //https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html
        switch nameLength {
        case let z where z <= shortNameMaxLength:       //shortNameEmployees
            section = 0
        case 5...6:                                     //mediumNameEmployees
            section = 1
        case let z where z > mediumNameMaxLength:       //longNameEmployees
            section = 2
        default:
            print("something bad happened here")
            return
        }
        allEmployees[section].append(employee)
        let destIndexPath = IndexPath(row: allEmployees[section].count - 1, section: section)
        tableView.insertRows(at: [destIndexPath], with: .left)
    }
    
    private func fetchEmployees(){
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else {return}
        allEmployees = sortAllEmployees(companyEmployees: companyEmployees)
    }
    
    @objc private func handleAdd(){
        let newVC = CreateEmployeeController()
        newVC.delegate = self
        newVC.company = company
        let newNav = CustomNavigationController(rootViewController: newVC)
        present(newNav, animated: true, completion: nil)
    }
    
    //MARK:- Overloaded Swift Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = UIColor.darkBlue
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        fetchEmployees()
    }
}
