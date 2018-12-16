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

    
    let tableID = "asdfpoiu"
    var companies = [Company]()
    
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableID, for: indexPath)
        cell.backgroundColor = .teal
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        let company = companies[indexPath.row]
        
        if let name = company.name, let founded = company.founded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let foundedDateString = dateFormatter.string(from: founded)
            let dateString = "\(name) --- \(foundedDateString)"
            cell.textLabel?.text = dateString
        } else {
            cell.textLabel?.text = "\(company.name ?? "")"
        }
        
        
        cell.imageView?.image =  #imageLiteral(resourceName: "select_photo_empty")
        
        if let  tempImage = company.imageData, let companyImage = UIImage(data: tempImage, scale: 0.8) {
            cell.imageView?.image = companyImage
        }
        
        return cell
    }
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {[unowned self] (_, indexPath) in
            let company = self.companies[indexPath.row]
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            do {
            try context.save()
            } catch let saveErr {
                print("Unable to save deletion changes \(saveErr)")
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        deleteAction.backgroundColor = .lightRed
        editAction.backgroundColor = .darkBlue
        return [deleteAction, editAction]
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ?  300  : 0
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "No Companies Defined \n Click Plus to insert", attributes: [NSAttributedString.Key.font: UIFont(name: "Papyrus", size: 25)!,
                                                                                                                       NSAttributedString.Key.foregroundColor : UIColor.yellow,
                                                                                                                        ])
        label.textAlignment = .center
        return label
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath){
        let editCompanyController = CreateCompanyController()
        editCompanyController.delegate = self
        editCompanyController.company = companies[indexPath.row]
        let navCompanyController = CustomNavigationController(rootViewController: editCompanyController)
        present(navCompanyController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCompanies()
        tableView.backgroundColor = UIColor.darkBlue
//        tableView.separatorStyle = .none  //remove lines from every row.  Even the blank rows that don't have cell data (ex: numberOfReturns = 2)
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()  //lets you keep the lines ONLY between your non-nil (valid) tableViewCells (ex: numberOfReturns = 2).
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableID)
        setupNavigationStyle()
    }
    
    
    private func fetchCompanies(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")       //Does <Company> === as! Company     ?????
        
        do {
        try companies = context.fetch(fetchRequest)
            
            companies.forEach{print("name = \($0.name ?? "")")}
//            print(companies)
        } catch let err {
            print("Unable to load [Companies] -- \(err)")
        }
    }
}

