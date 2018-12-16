//
//  File.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

extension CompaniesController {
    func didEditCompany(company: Company) {
        let destRow = companies.index(of: company)  //Does NOT auto-fill
        let destIndex = IndexPath(row: destRow ?? 0, section: 0)
        tableView.reloadRows(at: [destIndex], with: .middle)
    }
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let destIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [destIndexPath], with: .left)
    }
}
