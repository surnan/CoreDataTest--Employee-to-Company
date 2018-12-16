//
//  CompaniesController+TableView.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/16/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

extension CompaniesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableID, for: indexPath) as! CompanyCell
        cell.company = companies[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
}
