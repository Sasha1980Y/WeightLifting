//
//  Model.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 1/13/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation

struct Repetition {
    var number: Int
    var weight: Int
    init(number: Int, weight: Int) {
        self.number = number
        self.weight = weight
    }
}

struct Training {
    var nameExercises: String?
    var exercises: [Repetition]
    init(nameExercises: String) {
        self.nameExercises = nameExercises
        let number = 1
        let weight = 1
        let item1 = Repetition(number: number, weight: weight)
        var ar = [Repetition]()
        ar.append(item1)
        self.exercises = ar
    }
}

/*
 / count section
 arrayOfTraining.count
 // count of repetition
 arrayOfTraining[0].exercises.count
 
 print(arrayOfTraining[0].exercises)
 print(arrayOfTraining[1].exercises)
 arrayOfTraining[1].exercises.append(Repetition(number: 3, weight: 55))
 print(arrayOfTraining[1].exercises)
 

 */

