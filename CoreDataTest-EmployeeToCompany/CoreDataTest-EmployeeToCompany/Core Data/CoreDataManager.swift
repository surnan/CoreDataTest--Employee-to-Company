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
    
    
    
    func createEmployee(name: String, company: Company) -> (Employee?, Error?){
        let context = persistentContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        
        employee.company = company
        
        
        
        employee.setValue(name, forKey: "name")
        
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
//        employeeInformation.setValue("456", forKey: "taxId")  <--- always works
        employeeInformation.taxid = "456"       //<-- works because of casting above--> 'as! EmployeeInformation'
        
        employee.employeeinformation = employeeInformation  //OOOOOOPSIE  //To assign the data back to CoreData
        
        
        do {
            try context.save()
            return (employee , nil)
        } catch let saveErr {
            print("Unable to save employee entity: \(saveErr)")
            return (nil, saveErr)
        }
    }
    
    
    
    
    
    
    
    
    
}
