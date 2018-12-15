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
}


/*
 let persistentContainer = NSPersistentContainer(name: "CoreDataFile")                           //"CoreDataFile" <---- name of file
 persistentContainer.loadPersistentStores { (storeDescription, err) in
 if let err = err {
 fatalError("UNABLE TO LOAD STORE FAILED \(err)")
 }
 }
 
 let context = persistentContainer.viewContext
 let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)      //"Company" <--- name of entity
 company.setValue(nameTextField.text ?? "", forKey: "name")                                      //"Name" <--- name of attribute
 
 do {
 try context.save()
 self.dismiss(animated: true, completion: {
 self.delegate?.didAddCompany(company: company as! Company)
 //            let newCompany = Company(name: self.nameTextField.text ?? "", founded: Date())
 //            self.delegate?.didAddCompany(company: newCompany)
 })
 } catch let saveErr {
 print("Unable to save new company to Core Data \(saveErr)")
 }
 */
