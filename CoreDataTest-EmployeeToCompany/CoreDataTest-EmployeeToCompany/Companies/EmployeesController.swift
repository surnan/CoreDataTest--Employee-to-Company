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

enum EmployeeType: String {
    case Executive
    case SeniorManagement = "Senior Management"
    case Staff
}

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    
    var company: Company?
    let cellID = "asdfasdfasdf"
    var allEmployees =  [[Employee]]()

    
    var employeeTypes = [  //order listing determines employeeTypes.foreach Loop sequence start point
        EmployeeType.Executive.rawValue,
        EmployeeType.SeniorManagement.rawValue,
        EmployeeType.Staff.rawValue
    ]
    
    private func fetchEmployees(){
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else {return}
        employeeTypes.forEach { (employeeType) in
            allEmployees.append(companyEmployees.filter{$0.type == employeeType})
        }
    }
    
    
    
    func didAddEmployee(employee: Employee) {
        guard let employeeType = employee.type,
            let section = employeeTypes.index(of: employeeType) else {return}
        let row = allEmployees[section].count
        let destIndex = IndexPath(row: row, section: section)
        allEmployees[section].append(employee)
        tableView.insertRows(at: [destIndex], with: .left)
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




//        guard let nameLength = employee.name?.count else {return}
//        var section = 0
//        //https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html
//        switch nameLength {
//        case let z where z <= shortNameMaxLength:       //shortNameEmployees
//            section = 0
//        case mediumNameMinLength...mediumNameMaxLength:                                     //mediumNameEmployees
//            section = 1
//        case let z where z > mediumNameMaxLength:       //longNameEmployees
//            section = 2
//        default:
//            print("something bad happened here")
//            return
//        }
//        allEmployees[section].append(employee)
//        let destIndexPath = IndexPath(row: allEmployees[section].count - 1, section: section)
//        tableView.insertRows(at: [destIndexPath], with: .left)
