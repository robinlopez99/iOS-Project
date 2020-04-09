//
//  SecondViewController.swift
//  Clock-In-Out
//
//  Created by Robin Lopez Ordonez on 3/25/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var clockedOutButton: UIButton!
    @IBOutlet weak var clockedInButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forJobInput: UITextField!
    @IBOutlet weak var lastActionLabel: UILabel!
    var pickerData = ["General"]
    var jobChosen = "General"
    var lastIn = Date()
    var lastOut = Date()
    var lastInJob = String()
    var lastOutJob = String()
    let formatter = DateFormatter()
    let timeformat = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateStyle = .full
        timeformat.dateFormat = "MMM d, h:mm a"
        startDate()
        startPicker()
        getLastClock()
    }
    
    func startDate() {
        let currentDate = Date()
        formatter.dateStyle = .full
        dateLabel.text = formatter.string(from: currentDate)
    }
    
// MARK: PickerView and Toolbar Functions
    
    func startPicker() {
        forJobInput.text = pickerData[0]
        let jobPicker = UIPickerView()
        jobPicker.delegate = self
        jobPicker.dataSource = self
        forJobInput.inputView = jobPicker
        startToolBar()
        
    }
    
    func startToolBar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        forJobInput.inputAccessoryView = toolbar
        
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        forJobInput.text = pickerData[row]
        jobChosen = pickerData[row]
    }
    

// MARK: Clocking In and Out
    
    func getLastClock() {
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let requestIn = NSFetchRequest<NSFetchRequestResult>(entityName: "ClockIn")
        let requestOut = NSFetchRequest<NSFetchRequestResult>(entityName: "ClockOut")
        requestIn.returnsObjectsAsFaults = false
        requestOut.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(requestIn)
            for data in result as! [NSManagedObject] {
                lastIn = data.value(forKey: "time") as! Date
                lastInJob = data.value(forKey: "job") as! String
            }
        } catch {
            print("failed")
        }
        
        do {
            let result = try context.fetch(requestOut)
            for data in result as! [NSManagedObject] {
                lastOut = data.value(forKey: "time") as! Date
                lastOutJob = data.value(forKey: "job") as! String
            }
        } catch {
            print("failed")
        }
        
        if lastIn > lastOut {
            lastActionLabel.text = "Clock in: \(timeformat.string(from: lastIn)) for \(lastInJob)"
        } else if lastOut > lastIn {
            lastActionLabel.text = "Clocked out: \(timeformat.string(from: lastOut)) for \(lastOutJob)"
        } else {
            lastActionLabel.text = "None"
        }
    }
    
    @IBAction func clockedIn(_ sender: Any) {
        clockedInButton.isEnabled = true
        let currentTime = Date()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ClockIn", in: context)
            
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        newEntity.setValue(currentTime, forKey: "time")
        newEntity.setValue(jobChosen, forKey: "job")
        
        do {
            try context.save()
            lastActionLabel.text = "Clock in at: \(timeformat.string(from: currentTime))"
            lastOut = currentTime
        } catch {
            print("Failed Saving")
        }
    }
    
    
    @IBAction func clockedOut(_ sender: Any) {
        clockedOutButton.isEnabled = true
        let currentTime = Date()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ClockOut", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        newEntity.setValue(currentTime, forKey: "time")
        newEntity.setValue(jobChosen, forKey: "job")
        
        do {
            try context.save()
            lastActionLabel.text = "Clock out at: \(timeformat.string(from: currentTime))"
            lastIn = currentTime
        } catch {
            print("Failed Saving")
        }
        
    }
}

