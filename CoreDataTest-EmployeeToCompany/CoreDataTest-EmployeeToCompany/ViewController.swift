//
//  ViewController.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/14/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let tableID = "asdfpoiu"
    
    
    func setupNavigationStyle(){
        navigationItem.title = "Companies"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    
    @objc func handleAddCompany(){
        print("Adding Company")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableID, for: indexPath)
        cell.backgroundColor = .teal
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

