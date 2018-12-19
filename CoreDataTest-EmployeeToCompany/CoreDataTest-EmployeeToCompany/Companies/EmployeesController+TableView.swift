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
        //        return employees.count
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        //        let employee = employees[indexPath.item]
        let employee = allEmployees[indexPath.section][indexPath.row]
        cell?.textLabel?.text = employee.name
        cell?.backgroundColor = UIColor.teal
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell?.textLabel?.textColor = UIColor.white
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    //UIContextualAction

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
//        let temp = UISwipeActionsConfiguration(actions: UIContextualAction(style: .normal  , title: "Delete", handler: #selector(handleSwipeAction)))
        
        let temp = UIContextualAction(style: .normal, title: "My_Title") { (_, _, _) in
            print("Swipe Measured")
            
            
            
            
        }
        
        temp.image = #imageLiteral(resourceName: "plus")
        temp.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [temp])
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var text = ""
        switch section {
        case 0:
            text = "Short Names"
        case 1:
            text = "Medium Names"
        case 2:
            text = "Long Names"
        default:
            print("BAD THINGS HAPPENING")
        }
        
        let sectionLabel: UILabel = {
            let label = UILabel()
            label.text = text
            label.backgroundColor = UIColor.lightBlue
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
        }()
        return sectionLabel
    }
}



/*
 var labelString = "\(employee.name ?? "")...taxId = \(employee.employeeinformation?.taxid ?? "")"
 
 if let birthdayDate = employee.employeeinformation?.birthday {
 let dateFormatter = DateFormatter()
 dateFormatter.dateFormat = "MMM dd, yyyy"
 let birthdayString = dateFormatter.string(from: birthdayDate)
 labelString = labelString +  "...\(birthdayString)"
 }
 */
