//
//  EmployeesController+TableView.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/18/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

extension EmployeesController {
    
    //MARK:- TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        let employee = employees[indexPath.item]
        var labelString = "\(employee.name ?? "")...taxId = \(employee.employeeinformation?.taxid ?? "")"
        
        if let birthdayDate = employee.employeeinformation?.birthday {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let birthdayString = dateFormatter.string(from: birthdayDate)
            labelString = labelString +  "...\(birthdayString)"
        }
        cell?.textLabel?.text = labelString
        cell?.backgroundColor = UIColor.teal
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell?.textLabel?.textColor = UIColor.white
        return cell!
    }
    
}
