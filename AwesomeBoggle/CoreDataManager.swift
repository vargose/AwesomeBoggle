//
//  CoreDataManager.swift
//  AwesomeBoggle
//
//  Created by mitch.harris on 3/7/17.
//  Copyright © 2017 mitch.harris. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    func saveWord(text: String, definition: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Word", in: managedContext)
        if let entity = entity {
            let word = NSManagedObject(entity: entity, insertInto: managedContext)
            
            //3
            word.setValue(text, forKeyPath: "text")
            
            if let definition = definition {
                word.setValue(definition, forKey: "definition")
            }
            
            //4
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error)")
            }
        }
    }
    
    func fetchWordList() -> [NSManagedObject]? {
        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Word")
        
        //3
        var wordList:[NSManagedObject] = []
        do {
            wordList = try managedContext.fetch(fetchRequest)
            return wordList
        } catch let error as NSError {
            print("Could Not Fetch. \(error)")
            return nil
        }
    }
}
