//
//  ThirdViewController.swift
//  Clock-In-Out
//
//  Created by Robin Lopez Ordonez on 3/23/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var rateInput: UITextField!
    @IBOutlet weak var addCostsInput: UITextField!
    @IBOutlet weak var fromDateInput: UITextField!
    @IBOutlet weak var toDateInput: UITextField!
    @IBOutlet weak var forJobInput: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    var data = invoiceData(from: nil, to: nil, hourly: nil, additional: nil, job: nil)
    var rate = Int()
    var adds = Int()
    
    let datePicker = UIDatePicker()
    let picker = UIPickerView()
    
    private var fromDate = Date()
    private var toDate = Date()
    let dateformatter = DateFormatter()
    
    var pickerData = ["General"]
    var jobPicked = "General"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDatePicker()
        startPicker()
    }
    
    func startDatePicker() {
        datePicker.datePickerMode = .date
        fromDateInput.inputView = datePicker
        toDateInput.inputView = datePicker
        startToolBar()
    }
    
    func startPicker() {
        forJobInput.text = pickerData[0]
        picker.delegate = self
        picker.dataSource = self
        forJobInput.inputView = picker
        startToolBar()
    }
    
    func startToolBar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        fromDateInput.inputAccessoryView = toolbar
        toDateInput.inputAccessoryView = toolbar
        forJobInput.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        dateformatter.dateStyle = .short
        if fromDateInput.isFirstResponder {
            fromDate = datePicker.date
            fromDateInput.text = dateformatter.string(from: fromDate)
            self.view.endEditing(true)
        }
        if toDateInput.isFirstResponder {
            toDate = datePicker.date
            toDateInput.text = dateformatter.string(from: toDate)
            self.view.endEditing(true)
        }
        if forJobInput.isFirstResponder {
            self.view.endEditing(true)
        }
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
        jobPicked = pickerData[row]
    }
    
    @IBAction func getRate(_ sender: UITextField) {
        self.rate = Int(sender.text!) ?? 0
    }
    
    @IBAction func getAdds(_ sender: UITextField) {
        self.adds = Int(sender.text!) ?? 0
    }
    
    @IBAction func createTapped(_ sender: Any) {
        
        self.data = invoiceData(from: fromDate, to: toDate, hourly: self.rate, additional: self.adds, job: self.jobPicked)
        
        performSegue(withIdentifier: "toInvoice", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InvoiceViewController
        vc.incomingData = self.data
    }
    
    
}
