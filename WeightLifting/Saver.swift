//
//  Saver.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 2/28/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation
import CoreData

/*
 convenience init() {
 self.init(entity: CoreDataManager.instance.entityForName(entityName: "Model"), insertInto: CoreDataManager.instance.managedObjectContext)
 }
 
 
*/

class Saver {
    static let sharedInstance = Saver()
    
// save
    func saveToCoreData(date: Date, training: Data) {
        
        let context = CoreDataManager.instance.managedObjectContext
        // Описание сущности
        let entityDescription = NSEntityDescription.entity(forEntityName: "Model", in: context)
        
        // Создание нового объекта
        let managedObject = Model(entity: entityDescription!, insertInto: context)
        
        // managedObject це один запис до бази даних
        
        
        let dateRight = Helper.shared.shortFormatForDate(date: date)
        
        if let dateObj = dateRight {
            managedObject.date = dateObj as NSDate
            managedObject.training = training as NSData
        } else {
            return
        }
        
        // Запись объекта
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
// get Core Data
    func selectQuestion(date: Date) -> [Model]? {
        let context = CoreDataManager.instance.managedObjectContext
        let fetchRequest: NSFetchRequest<Model> = Model.fetchRequest()
        
        let shortDate = Helper.shared.shortFormatForDate(date: date)
        let nsDate = shortDate as NSDate?
        
        if let fetchDate = nsDate {
            fetchRequest.predicate = NSPredicate(format: "date == %@", fetchDate)
        } else {
            return nil
        }
        
        do {
            let array = try context.fetch(fetchRequest) as [Model]
            return array
        } catch let errore {
            print("error FetchRequest \(errore)")
        }
        
        return nil
    }
    
// replace data in CoreData
    func replaceCoreData(enterDate: Date, training: Data) {
        let context = CoreDataManager.instance.managedObjectContext
        let fetchRequest: NSFetchRequest<Model> = Model.fetchRequest()
        
        let enterDateToShort = Helper.shared.shortFormatForDate(date: enterDate)
        
        do {
            let array = try context.fetch(fetchRequest) //as [Model]
            
            for result in array as [NSManagedObject] {
                // clean CoreData if need
                // result.managedObjectContext?.delete(result)
                let shortDate = result.value(forKey: "date") as? Date
                
                if let date = shortDate {
                    if date == enterDateToShort {
                        result.setValue(training, forKey: "training")
                    }
                }
            }
        } catch let errore {
            print("error FetchRequest \(errore)")
        }
    }
}
