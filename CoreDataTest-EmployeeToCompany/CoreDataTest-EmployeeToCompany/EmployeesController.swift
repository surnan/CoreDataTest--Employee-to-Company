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
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        tableView.reloadData()
//        let insertIndexPath = IndexPath(row: employees.count - 1, section: 0)
//        tableView.insertRows(at: [insertIndexPath], with: .left)
    }

    
    var company: Company?
    var employees = [Employee]()
    let cellID = "asdfasdfasdf"
    var allEmployees =  [[Employee]]()
    var shortNameEmployees = [Employee]()
    var mediumNameEmployees = [Employee]()
    var longNameEmployees = [Employee]()
    
    
    private func fetchEmployees(){
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else {return}
        //employees = company?.employees //NSSet vs [Employee]
        employees = companyEmployees

            shortNameEmployees = companyEmployees.filter({ (employee) -> Bool in
                if (employee.name?.count)! < 5 {
                    return true
                }
                return false
            })
        
            mediumNameEmployees = companyEmployees.filter({ (employee) -> Bool in
                if (employee.name?.count)! >= 5  &&   (employee.name?.count)! <= 6{
                    return true
                }
                return false
            })
        
            longNameEmployees = companyEmployees.filter({ (employee) -> Bool in
                if (employee.name?.count)! > 6 {
                    return true
                }
                return false
            })

        allEmployees = [shortNameEmployees, mediumNameEmployees, longNameEmployees]
        
        shortNameEmployees.forEach{print("Short = \($0.name ?? "")")}
        mediumNameEmployees.forEach{print("medium = \($0.name ?? "")")}
        longNameEmployees.forEach{print("long = \($0.name ?? "")")}
    }
    
    

    @objc private func handleAdd(){
        print("ADD EMPLOYEE")
        
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
    
    

    //MARK:- 2D array stuff
    

}
