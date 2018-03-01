//
//  EnterViewController.swift
//  WeightLifting
//
//  Created by Alexander Yakovenko on 1/10/18.
//  Copyright © 2018 Alexander Yakovenko. All rights reserved.
//

// Training or planning

import UIKit

class EnterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var trainingOrPlanningLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var section = [String]()
    var arrayExercises = [String]()
    
    var arrayOfTraining = [Training]()
    
    
    var custom = Custom()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfTraining.append(Training(nameExercises: "New exercises"))
        
        for item in arrayOfTraining {
            section.append(item.nameExercises!)
        }
        
        
        section =  ["dash", "push", "sit-ups"]
        arrayExercises = ["repetition 1", "repetition 2", "repetition 3"]
        tableView.delegate = self
        
        addDateToday()
        
        //
        var exercise = Exercise(name: "push", repetitionArray: [Exercise.Repetition2(weight: 25, checkDone: false)])
        exercise.repetitionArray.append(Exercise.Repetition2(weight: 35, checkDone: false))
        
        //
        tableView.register(UINib.init(nibName: "RepetitionCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // add data today
    func addDateToday() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        dataLabel.text = result
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: TableView
    /*
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.backgroundColor = UIColor.blue
        header.textLabel?.text = arrayOfTraining[section].nameExercises
        
        // add Gesture for section
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToSection))
        header.addGestureRecognizer(tapGesture)
    }
    */
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // it is mechanism that is responsible for
        // tap to section and get number of section + call func selectedSectionStoredButtonClicked
        //let titleHeader =  arrayOfTraining[section].nameExercises // Also set on button
        let  headerCell = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        headerCell.backgroundColor = UIColor.cyan
        
        // edit Button
        let editButton = UIButton(frame: CGRect(x: tableView.frame.size.width - 100, y: 0, width: 50, height: 50))
        editButton.addTarget(self, action: #selector(editSectionStoredButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        editButton.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
        editButton.tag = section
        headerCell.addSubview(editButton)
        
        
        // plus Button
        let plusButton = UIButton(frame: CGRect(x: tableView.frame.size.width - 50, y: 0, width: 50, height: 50))
        plusButton.addTarget(self, action: #selector(selectedSectionStoredButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        plusButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        
        plusButton.tag = section
        headerCell.addSubview(plusButton)
        
        // label with title for header
        let titleHeader = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width - 100, height: 50))
        titleHeader.text = arrayOfTraining[section].nameExercises
        headerCell.addSubview(titleHeader)
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return section.count
        return arrayOfTraining.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return arrayExercises.count
        return arrayOfTraining[section].exercises.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RepetitionCellTableViewCell
        cell.weightAndCountTextField.text = "Repetition " + String(indexPath.row) + "  weight " + String(arrayOfTraining[indexPath.section].exercises[indexPath.row].weight)
        
        
        
        //let array = arrayOfTraining[indexPath.row].exercises
        //let frame = cell?.frame
        
        /*
        let textField = UITextField(frame: CGRect(x: 10, y: 0, width: (cell?.bounds.width)! - 50, height: (cell?.frame.height)!))
        print("bounds.width", cell?.bounds.width ?? "not bounds.width")
        print("bounds.frame", cell?.frame.width ?? "not frame.width")
        textField.text = "Repetition " + String(indexPath.row) + "  weight " + String(arrayOfTraining[indexPath.section].exercises[indexPath.row].weight)
        textField.isEnabled = false
        textField.backgroundColor = UIColor.darkGray
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editTextField(textField:)))
        gestureRecognizer.numberOfTapsRequired = 2
        textField.addGestureRecognizer(gestureRecognizer)
        cell?.addSubview(textField)
        
        /*
         
         // add textField or picker
         
        let textField = UITextField(frame: CGRect(x: 10, y: 0, width: (cell?.frame.width)! - 50, height: (cell?.frame.height)!))
        textField.text = "tra-ta-ta"
        
        let customPicker = Custom(frame: CGRect(x: 0, y: 0, width: (cell?.frame.width)! - 50, height: 50))
        
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: (cell?.frame.width)! - 50, height: 50))
        customPicker.backgroundColor = UIColor.blue
        customPicker.dataSource = custom
        customPicker.delegate = custom
        cell?.addSubview(customPicker)
        */
        
        
        //cell?.addSubview(textField)
        
        //cell?.textLabel?.text = "Repetition " + String(indexPath.row) + "  weight " + String(arrayOfTraining[indexPath.section].exercises[0].weight)
        //cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        */
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        arrayOfTraining[section].exercises.append(Repetition(number: 20, weight: 45))
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: Function
    
    @IBAction func addSectionInTable(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Enter new exersice", preferredStyle: .alert)
        alert.addTextField { (_) in
        }
        let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
            let textField = alert?.textFields![0]
            if let text = textField?.text {
                self.section.append(text)
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        tableView.reloadData()
        
    }
    // TapGesture for section
    @objc func tapToSection() {
        print("tapped section")
    }
    
    @objc func selectedSectionStoredButtonClicked(sender: UIButton) {
        print("select footer")
        
        let alert = UIAlertController(title: nil, message: "Enter new exersice", preferredStyle: .alert)
        alert.addTextField { (_) in
        }
        let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
            let textField = alert?.textFields![0]
            if let text = textField?.text {
                self.arrayOfTraining.append(Training(nameExercises: text))
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        tableView.reloadData()
    }
    
    @objc func editSectionStoredButtonClicked(sender: UIButton) {
    
        print(sender.tag)
        let alert = UIAlertController(title: nil, message: "Edit exercise", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.text = self.arrayOfTraining[sender.tag].nameExercises
            
        }
        let action = UIAlertAction(title: "OK", style: .default) { [weak alert](_) in
            self.arrayOfTraining[sender.tag].nameExercises = alert?.textFields![0].text
            self.tableView.reloadData()
            print("end")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        tableView.reloadData()
        
        print("presed edit section")
    }
    
    @objc func editTextField(textField: UITextField) {
        print("edit")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
