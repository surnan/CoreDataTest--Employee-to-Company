//
//  ViewController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData


protocol CreateCompanyControllerDelegate{
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
    
    let tableID = "asdfpoiu"
    var companies = [Company]()
    var error: Error?
    
    func setupNavigationStyle(){
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddCompany))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
    @objc private func handleReset(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        //slow way --> get context & run context.delete on each
        //Entity.fetchRequest used below is supplied by default with Core Data
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            //            companies.removeAll()     <--- doesn't give you the chance to show animation
            //            tableView.reloadData()  <--- doesn't give you the chance to show animation
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in companies.enumerated() {
                let tempIndexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(tempIndexPath)
            }
            self.companies.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .fade)
        } catch let deleteAllErr {
            print("Batch Delete Error: \(deleteAllErr)")
        }
    }
    
    
    @objc private func handleAddCompany(){
        let newCreateCompanyContoller = CreateCompanyController()
        newCreateCompanyContoller.delegate = self
        let newVC = CustomNavigationController(rootViewController: newCreateCompanyContoller)
        present(newVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (companies, error) = CoreDataManager.shared.fetchCompanies()  //Because we're in ViewDidLoad we don't need 'tableView.reloadData()'
        tableView.backgroundColor = UIColor.darkBlue
//        tableView.separatorStyle = .none  //remove lines from every row.  Even the blank rows that don't have cell data (ex: numberOfReturns = 2)
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()  //lets you keep the lines ONLY between your non-nil (valid) tableViewCells (ex: numberOfReturns = 2).
        tableView.register(CompanyCell.self, forCellReuseIdentifier: tableID)
        setupNavigationStyle()
    }
}

