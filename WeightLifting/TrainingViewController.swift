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
    
    var myTraining: [Exercises] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        myTraining.append(Exercises(name: "Exercise № 1", repetitionsArray: [Exercises.RepetitionCount(weight: 0)]))
        
        // nib for cell
        let nib = UINib(nibName: "RepetitionCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
       
    }
    
    func saveToCoreData(date: Int64) {
        
    }
    
    func getValue() {
        
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
        headerCell.backgroundColor = UIColor.cyan
        
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
        cell.weightAndCountTextField?.text = "Подход №" + "\(indexPath.row + 1)" + "  " + "Вес \(myTraining[indexPath.section].repetitionsArray[indexPath.row].weight)"
        cell.editButton.addTarget(self, action: #selector(editButton(sender:)), for: .touchUpInside)
        cell.plusButton.addTarget(self, action: #selector(plusButton(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    
// MARK: selector func for Rows
    
    @IBAction func plusButton(sender: UIButton) {
        if let cell = sender.superview?.superview as? RepetitionCellTableViewCell {
            let indexPath = tableView.indexPath(for: cell)
            print("main button sect  sect", (indexPath?.row)! + 1)
            print("main button row  row", (indexPath?.section)! + 1)
            
            if let index = indexPath?.section {
                let alert = UIAlertController(title: nil, message: "Enter new weight", preferredStyle: .alert)
                alert.addTextField { (_) in
                }
                let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
                    let textField = alert?.textFields![0]
                    if let text = Int((textField?.text)!) {
                        self.myTraining[index].repetitionsArray.append(Exercises.RepetitionCount.init(weight: text))
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
                if let indexS = indexPath?.section, let indexR = indexPath?.row {
                    tf.text = String(self.myTraining[indexS].repetitionsArray[indexR].weight)
                }
            }
            let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
                let textField = alert?.textFields![0]
                
                if let text = textField?.text {
                    if let indexS = indexPath?.section, let indexR = indexPath?.row {
                        if let intText = Int(text) {
                            self.myTraining[indexS].repetitionsArray[indexR].weight = intText
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
                self.myTraining.append(Exercises(name: text, repetitionsArray: [Exercises.RepetitionCount(weight: 0)]))
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

