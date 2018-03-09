//
//  Model+CoreDataProperties.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 3/2/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//
//

import Foundation
import CoreData


extension Model {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Model> {
        return NSFetchRequest<Model>(entityName: "Model")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var training: NSData?

}
