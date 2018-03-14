//
//  TrainingViewController.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 2/26/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

import UIKit
import CoreData

class TrainingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateButton: UIButton!
    
    var currentDate: Date = Date()
    
    var myTraining: [Exercises] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        myTraining.append(Exercises(name: "Ривок", repetitionsArray: [Exercises.RepetitionCount(weight: 0, count: 1)]))
        // nib for cell
        let nib = UINib(nibName: "RepetitionCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        // insert date today to button "Date"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MMM.yyyy"
        let dateText = formatter.string(from: date)
        dateButton.setTitle(dateText, for: .normal)
        
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.tableView.reloadData()
    }
    
    
    // MARK: Alert DatePicker
    @IBAction func dateAlertButton(_ sender: Any) {
        alertWithDatePicker()
    }
    
    func alertWithDatePicker() {
        let myDatePicker: UIDatePicker = UIDatePicker()
        // setting properties of the datePicker
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        myDatePicker.datePickerMode = .date
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(myDatePicker)
        let somethingAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        myDatePicker.addTarget(self, action: #selector(valueChangedDatePicker(picker:)), for: .valueChanged)
        // without this don't work with today date
        myDatePicker.date = currentDate
        self.present(alertController, animated: true, completion:{})
    }
    
    @objc func valueChangedDatePicker(picker: UIDatePicker) {
        // Date to String
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MMM.yyyy"
        let dateText = formatter.string(from: picker.date)
        currentDate = picker.date
        
        self.dateButton.setTitle(dateText, for: .normal)
    }
    
// MARK: save date to CoreData
    
    @IBAction func saveToCoreData(_ sender: UIBarButtonItem) {
        guard let dataFromTraining = try? JSONEncoder().encode(myTraining) else {
            return
        }
        if let output = Saver.sharedInstance.selectQuestion(date: currentDate) {
            if output.count > 0 {
                Saver.sharedInstance.replaceCoreData(enterDate: currentDate, training: dataFromTraining)
                print("Saved replace object")
                return
            } else {
                
            }
        }
        Saver.sharedInstance.saveToCoreData(date: currentDate, training: dataFromTraining)
    }
    
    @IBAction func uploadFromCoreData(_ sender: UIBarButtonItem) {
        if let output = Saver.sharedInstance.selectQuestion(date: currentDate) {
            if output.count > 0 {
                print("count of training = ", output.count)
                if let training = output[0].training {
                    if let trainingArray = try? JSONDecoder().decode([Exercises].self, from: training as Data) {
                        myTraining = trainingArray
                        self.tableView.reloadData()
                    }
                } else {
                    
                }
            } else {
                emptyTrainingList()
            }
        } else {
            emptyTrainingList()
        }
    }
    
    // reload empty table
    func emptyTrainingList() {
        myTraining = []
        myTraining.append(Exercises(name: "Ривок", repetitionsArray: [Exercises.RepetitionCount(weight: 0, count: 1)]))
        self.tableView.reloadData()
    }
    
    
}

extension TrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension TrainingViewController: UITableViewDataSource {
    
// MARK: Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return myTraining.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        
        let red = UIColor(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1.0)
        headerCell.backgroundColor = red
        
        // edit Button
        let editButton = UIButton(frame: CGRect(x: tableView.frame.size.width - 100, y: 0, width: 50, height: 50))
        editButton.addTarget(self, action: #selector(editSectionButton(sender:)), for: UIControlEvents.touchUpInside)
        editButton.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
        editButton.tag = section
        headerCell.addSubview(editButton)
        
        // plus Button
        let plusButton = UIButton(frame: CGRect(x: tableView.frame.size.width - 50, y: 0, width: 50, height: 50))
        plusButton.addTarget(self, action: #selector(plusSectionButton(sender:)), for: UIControlEvents.touchUpInside)
        plusButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        headerCell.addSubview(plusButton)
        
        // label with title for header
        let titleHeader = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width - 100, height: 50))
        //titleHeader.font = UIFont.systemFont(ofSize: 20)
        titleHeader.font = UIFont.boldSystemFont(ofSize: 20)
        titleHeader.text = myTraining[section].name
        headerCell.addSubview(titleHeader)
         
        return headerCell
        
    }
    
// MARK: Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTraining[section].repetitionsArray.count //repArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RepetitionCellTableViewCell
        cell.weightAndCountTextField?.text = "№" + "\(indexPath.row + 1)" + "  " + "Вага \(myTraining[indexPath.section].repetitionsArray[indexPath.row].weight)" + "  Повтор \(myTraining[indexPath.section].repetitionsArray[indexPath.row].count)"
        cell.editButton.addTarget(self, action: #selector(editButton(sender:)), for: .touchUpInside)
        cell.plusButton.addTarget(self, action: #selector(plusButton(sender:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if indexPath.section > 0 {
                myTraining[indexPath.section].repetitionsArray.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                if indexPath.row == 0 {
                    myTraining.remove(at: indexPath.section)
                    self.tableView.reloadData()
                }
            } else {
                if indexPath.row > 0 {
                    myTraining[indexPath.section].repetitionsArray.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                } else {
                    self.emptyTrainingList()
                }
            }
        }
    }
    
// MARK: selector func for Rows
    
    @IBAction func plusButton(sender: UIButton) {
        if let cell = sender.superview?.superview as? RepetitionCellTableViewCell {
            let indexPath = tableView.indexPath(for: cell)
            print("main button sect  sect", (indexPath?.row)! + 1)
            print("main button row  row", (indexPath?.section)! + 1)
            if let index = indexPath?.section {
                let alert = UIAlertController(title: nil, message: "Enter new weight", preferredStyle: .alert)
                alert.addTextField { (tf) in
                    tf.keyboardType = UIKeyboardType.decimalPad
                }
                alert.addTextField { (tf) in
                    tf.keyboardType = UIKeyboardType.decimalPad
                }
                let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
                    let textField = alert?.textFields![0]
                    let textField2 = alert?.textFields![1]
                    if let text = Int((textField?.text)!) {
                        let text2 = Int((textField2?.text)!); self.myTraining[index].repetitionsArray.append(Exercises.RepetitionCount.init(weight: text, count: text2 ?? 1))
                        self.tableView.reloadData()
                    }
                }
                
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            
        }
        self.tableView.reloadData()
    }
    
    @IBAction func editButton(sender: UIButton) {
        if let cell = sender.superview?.superview as? RepetitionCellTableViewCell {
            let indexPath = tableView.indexPath(for: cell)
            
            let alert = UIAlertController(title: nil, message: "Edit exercise", preferredStyle: .alert)
            alert.addTextField { (tf) in
                tf.keyboardType = UIKeyboardType.decimalPad
                if let indexS = indexPath?.section, let indexR = indexPath?.row {
                    tf.text = String(self.myTraining[indexS].repetitionsArray[indexR].weight)
                }
            }
            alert.addTextField { (tf) in
                tf.keyboardType = UIKeyboardType.decimalPad
                if let indexS = indexPath?.section, let indexR = indexPath?.row {
                    tf.text = String(self.myTraining[indexS].repetitionsArray[indexR].count)
                }
            }
            let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
                let textField = alert?.textFields![0]
                let textField2 = alert?.textFields![1]
                if let text = textField?.text, let text2 = textField2?.text {
                    
                    if let indexS = indexPath?.section, let indexR = indexPath?.row {
                        if let intText = Int(text), let intText2 = Int(text2) {
                            self.myTraining[indexS].repetitionsArray[indexR].weight = intText
                            self.myTraining[indexS].repetitionsArray[indexR].count = intText2
                        }
                    }
                    self.tableView.reloadData()
                }
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        self.tableView.reloadData()
    }
    
// MARK: selector func for Header
    
    @objc func plusSectionButton(sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Enter new exersice", preferredStyle: .alert)
        alert.addTextField { (_) in
        }
        let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
            let textField = alert?.textFields![0]
            if let text = textField?.text {
                self.myTraining.append(Exercises(name: text, repetitionsArray: [Exercises.RepetitionCount(weight: 0, count: 1)]))
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func editSectionButton(sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Edit exercise", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.text = self.myTraining[sender.tag].name
        }
        let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
            self.myTraining[sender.tag].name = (alert?.textFields![0].text)!
            self.tableView.reloadData()
            print("end")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

