//
//  RepetitionCellTableViewCell.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 1/17/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit

class RepetitionCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weightAndCountTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
}
