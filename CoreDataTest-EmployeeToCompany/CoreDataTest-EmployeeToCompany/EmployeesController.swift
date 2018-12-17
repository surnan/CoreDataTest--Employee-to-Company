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

    
    private func fetchAllEmployees(){
        //ALL employees from ALL companies
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        do {
            employees = try context.fetch(request)
            employees.forEach{print($0.name ?? "")}
        } catch let fetchErr {
            print("Unable to fetch employees \(fetchErr)")
        }
    }
    
    
    private func fetchEmployees(){
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else {return}
        //employees = company?.employees //NSSet vs [Employee]
        employees = companyEmployees
    }
    
    
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
    
    @objc private func handleAdd(){
        print("ADD EMPLOYEE")
        
        let newVC = CreateEmployeeController()
        newVC.delegate = self
        newVC.company = company
        let newNav = CustomNavigationController(rootViewController: newVC)
        present(newNav, animated: true, completion: nil)
    }
    
    
    //MARK:- TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        let employee = employees[indexPath.item]
        
        cell?.textLabel?.text = "\(employee.name ?? "")...taxId = \(employee.employeeinformation?.taxid ?? "")"
        cell?.backgroundColor = UIColor.teal
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell?.textLabel?.textColor = UIColor.white
        return cell!
    }
}
