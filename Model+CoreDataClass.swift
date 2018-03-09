//
//  Model+CoreDataClass.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 3/2/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//
//

import Foundation
import CoreData


public class Model: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Model"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
