//
//  SecondViewController.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 1/16/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var dataPicker: UIPickerView!
    
    @IBOutlet weak var button: UIButton!
    
    
    
    var array = ["1","2","3"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPicker.dataSource = self
        dataPicker.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap) )
        gestureRecognizer.numberOfTapsRequired = 2
        button.addGestureRecognizer(gestureRecognizer)
        
        
        
        
        
    }
    
    // MARK:  picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    // MARK: tap gesture
    @objc func doubleTap() {
        print("Double tap")
    }
    

}
