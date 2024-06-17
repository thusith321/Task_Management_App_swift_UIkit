//
//  DBManager.swift
//  TaskManagementApp
//
//  Created by Thusith Hettiarachchi on 2024-04-22.
//

import CoreData
import UIKit

class DBManager {
    static let share = DBManager()
    
    //save
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskManagementApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var  context = persistentContainer.viewContext
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //fetch
    func fetchAllPendingTasks() -> [TaskManageEntity] {
        var pending = [TaskManageEntity]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TaskManageEntity.description())
        fetchRequest.predicate = NSPredicate(format: "taskstatus == %@", argumentArray: [false])

        do {
            pending = try context.fetch(fetchRequest) as! [TaskManageEntity]
            print(pending)
        }
        catch {
            print("Error")
        }
        return pending
    }
    
    func fetchAllCompeleteTask () -> [TaskManageEntity] {
        var task = [TaskManageEntity]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TaskManageEntity.description())
        fetchRequest.predicate = NSPredicate(format: "taskstatus == %@", argumentArray: [true])

        do{
            task = try context.fetch(fetchRequest) as! [TaskManageEntity]
        }
        catch{
            print("Fetching Error")
        }
        
        return task
    }
    
    
    
}
