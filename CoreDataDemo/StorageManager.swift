//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Никита Бат on 07.12.2021.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
    
    private init() {}
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchContext() -> [Task] {
        do {
            return try context.fetch(Task.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func deleteContext(_ task: Task) {
        context.delete(task)
    }
    
}
