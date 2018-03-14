//
//  ModelT.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 2/26/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation

/*
struct Exercises {
    var name: String
    var repetitionsArray: [RepetitionCount]
    struct RepetitionCount {
        var weight: Int
    }
}
*/


struct ExerciseWithDate {
    var number: Int
    var date: Date
    var arrayForSave: [Exercise]
}

struct Exercises: Codable {
    var name: String
    var repetitionsArray: [RepetitionCount]
    var description: [String: Any] {
        get {
            return ["name": name, "repetitionsArray": repetitionsArray] as [String : Any]
        }
    }
    
    struct RepetitionCount: Codable {
        var weight: Int
        var count: Int
        var description: [String: Any] {
            get {
                return ["weight": weight] as [String : Any]
            }
        }
    }
}
