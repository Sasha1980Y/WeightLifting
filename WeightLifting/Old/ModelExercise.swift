//
//  ModelExercise.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 1/15/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import Foundation

struct Exercise {
    var name: String
    var repetitionArray = [Repetition2]()
    
    struct Repetition2 {
        var weight: Int
        var checkDone: Bool
    }
}
