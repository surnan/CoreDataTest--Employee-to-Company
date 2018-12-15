//
//  ViewController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {

    let tableID = "asdfpoiu"

    let companies = [
    Company(name: "Google", founded: Date()),
    Company(name: "Apple", founded: Date()),
    Company(name: "Microsoft", founded: Date())
    ]
    
    
    func setupNavigationStyle(){
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    
    @objc func handleAddCompany(){
        let newVC = CustomNavigationController(rootViewController: CreateCompanyController())
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
        cell.textLabel?.text = companies[indexPath.item].name
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.darkBlue
//        tableView.separatorStyle = .none  //remove lines from every row.  Even the blank rows that don't have cell data (ex: numberOfReturns = 2)
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()  //lets you keep the lines ONLY between your non-nil (valid) tableViewCells (ex: numberOfReturns = 2).
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableID)
        setupNavigationStyle()
    }
}

