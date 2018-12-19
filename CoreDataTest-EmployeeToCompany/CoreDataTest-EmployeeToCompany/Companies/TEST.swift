//
//  TEST.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/19/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit



extension EmployeesController {

    func sortAllEmployees(companyEmployees: [Employee]) -> [[Employee]] {
        var dummyReturn = [[Employee]]()
        enum allCompanyEnum: Int {
            case shortNameMaxLength = 0
            case mediumNameMaxLength
            case longNameMaxLength
        }

        var shortNameEmployees = [Employee]()
        var mediumNameEmployees = [Employee]()
        var longNameEmployees = [Employee]()

        companyEmployees.forEach { (employee) in
            guard let nameLength = employee.name?.count else {return}
            switch nameLength {
            case let z where z < shortNameMaxLength:
                shortNameEmployees.append(employee)
            case 5...6 :
                mediumNameEmployees.append(employee)
            case let z where z > mediumNameMaxLength:
                longNameEmployees.append(employee)
            default:
                print("INVALID Section")
                return
            }
        }
        dummyReturn = [shortNameEmployees, mediumNameEmployees, longNameEmployees]
        return  dummyReturn
    }
}




/*
         shortNameEmployees = companyEmployees.filter({ (employee) -> Bool in
             if (employee.name?.count)! <= shortNameMaxLength {
                 return true
             }
             return false
         })
         mediumNameEmployees = companyEmployees.filter({ (employee) -> Bool in
             if (employee.name?.count)! > shortNameMaxLength  &&   (employee.name?.count)! <= mediumNameMaxLength{
                 return true
             }
             return false
         })
         longNameEmployees = companyEmployees.filter({ (employee) -> Bool in
             if (employee.name?.count)! > mediumNameMaxLength {
                 return true
             }
             return false
         })
 */

 /*
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
*/
