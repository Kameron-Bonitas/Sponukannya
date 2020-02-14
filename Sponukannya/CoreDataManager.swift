//
//  CoreDataManager.swift
//  Sponukannya
//
//  Created by Ben on 12.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
//    1
    static let sharedManager = CoreDataManager()
    //Zapobigannya stvorennya another instance (?)
    private init() {}
    
//    2
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Sponukannya")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()
    
//    3
    func saveContext () {
      let context = CoreDataManager.sharedManager.persistentContainer.viewContext
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          // Replace this implementation with code to handle the error appropriately.
          // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
    
    // MARK: Insert
    func insertAffirmation(name: String)->MyAffirmationItem? {
      
      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
      let affirmation = MyAffirmationItem(context: managedContext)
      
      affirmation.setValue(name, forKeyPath: "name")
        print("\(affirmation.value(forKey: "name") ?? "")")
      
      do {
        try managedContext.save()
        return affirmation as? MyAffirmationItem
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        return nil
      }
    }

    // MARK: Update
    func update(name:String, affirmation : MyAffirmationItem) {
      
     let context = CoreDataManager.sharedManager.persistentContainer.viewContext
      do {
        affirmation.setValue(name, forKey: "name")
print("\(affirmation.value(forKey: "name") ?? "")")
       
        do {
          try context.save()
          print("saved!")
        } catch let error as NSError  {
          print("Could not save \(error), \(error.userInfo)")
        } catch {
          
        }
        
      } catch {
        print("Error with request: \(error)")
      }
    }
    
    // MARK: Delete
    func delete(affirmation : MyAffirmationItem){
      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
      do {
        managedContext.delete(affirmation)
        } catch {
        // Do something in response to error condition
        print(error)
        }
      do {
        try managedContext.save()
        } catch {
        // Do something in response to error condition
        }
    }
 
// MARK: Fetching
    func fetchAllAffirmations() -> [MyAffirmationItem]?{
      
      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
      
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MyAffirmationItem")
    
      do {
        let myAffis = try managedContext.fetch(fetchRequest)
        return myAffis as? [MyAffirmationItem]
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        return nil
      }
    }
    
    
//MARK: Flush Data ???????????????????? NAS
    /*In cases we need to flush data, we can call this method*/
    func flushData() {
      
      let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
      let objs = try! CoreDataManager.sharedManager.persistentContainer.viewContext.fetch(fetchRequest)
      for case let obj as NSManagedObject in objs {
        CoreDataManager.sharedManager.persistentContainer.viewContext.delete(obj)
      }
      
      try! CoreDataManager.sharedManager.persistentContainer.viewContext.save()
    }
    
    
    
    
    lazy var fetchedResultsController: NSFetchedResultsController<MyAffirmationItem> = {
      
      /*Before you can do anything with Core Data, you need a managed object context. */
      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
      
      /*As the name suggests, NSFetchRequest is the class responsible for fetching from Core Data.
       
       Initializing a fetch request with init(entityName:), fetches all objects of a particular entity. This is what you do here to fetch all Person entities.
       */
      let fetchRequest = NSFetchRequest<MyAffirmationItem>(entityName: "MyAffirmationItem")
      
      // Add Sort Descriptors
//      let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
       let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
      fetchRequest.sortDescriptors = [sortDescriptor]
      
      // Initialize Fetched Results Controller
      let fetchedResultsController = NSFetchedResultsController<MyAffirmationItem>(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
      
      print("1. NSFetchResultController Initialized :)")
      return fetchedResultsController
    }()
    
}
