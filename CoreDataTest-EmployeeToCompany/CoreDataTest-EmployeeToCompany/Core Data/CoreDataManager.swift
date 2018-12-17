//
//  CoreDataManager.swift
//  CoreDataTest-EmployeeToCompany
//
//  Created by admin on 12/15/18.
//  Copyright © 2018 admin. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()       //Only Static variable!!
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataFile")     //"CoreDataFile" <---- name of file
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("UNABLE TO LOAD STORE FAILED \(err)")
            }
        }
        return container
    }()
    
//    func fetchCompanies() -> [Company]{
//        let context = persistentContainer.viewContext  //persistenContainer defined above
//        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")       //Does <Company> === as! Company     ?????
//        var companies = [Company]()
//        do {
//            try companies = context.fetch(fetchRequest)
//        } catch let err {
//            fatalError("Unable to fetch companies -- \(err)")
//        }
//        return companies
//    }
    
    
    func fetchCompanies() -> ([Company], Error?){
        let context = persistentContainer.viewContext  //persistenContainer defined above
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")       //Does <Company> === as! Company     ?????
        var companies = [Company]()
        do {
            try companies = context.fetch(fetchRequest)
            return (companies, nil)
        } catch let err {
            print("Unable to fetch companies -- \(err)")
            return ([Company](), err)
        }
    }
    
    
    
    func createEmployee(name: String) -> Error?{
        let context = persistentContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
        
        employee.setValue(name, forKey: "name")
        
        do {
            try context.save()
            return nil
        } catch let saveErr {
            print("Unable to save employee entity: \(saveErr)")
            return saveErr
        }
    }
    
    
    
    
    
    
    
    
    
}
