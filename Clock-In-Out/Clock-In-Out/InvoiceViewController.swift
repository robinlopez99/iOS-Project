//
//  InvoiceViewController.swift
//  Clock-In-Out
//
//  Created by Robin Lopez Ordonez on 3/30/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import UIKit
import CoreData

class InvoiceViewController: UIViewController {

    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var additionalCostsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    
    var incomingData = invoiceData(from: nil, to: nil, hourly: nil, additional: nil, job: nil)
    
    let dateFormatter = DateFormatter()
    var allIn = [Date]()
    var allOut = [Date]()
    var inJobs = [String]()
    var outJobs = [String]()
    var totalHours = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        parseData()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        hoursLabel.text = String(format:"%.2f",totalHours)
        jobLabel.text = incomingData.job
        datesLabel.text = "\(dateFormatter.string(from: incomingData.fromDate)) to \(dateFormatter.string(from: incomingData.toDate))"
        costLabel.text = "\(incomingData.hourly)"
        additionalCostsLabel.text = "\(incomingData.additional)"
        totalLabel.text = String(format: "%.2f",(totalHours * Double(incomingData.hourly) + Double(incomingData.additional)))
        
    }
    
    func getData() {
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let requestIn = NSFetchRequest<NSFetchRequestResult>(entityName: "ClockIn")
        let requestOut = NSFetchRequest<NSFetchRequestResult>(entityName: "ClockOut")
        requestIn.returnsObjectsAsFaults = false
        requestOut.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(requestIn)
            for data in result as! [NSManagedObject] {
                allIn.append(data.value(forKey: "time") as! Date)
                inJobs.append(data.value(forKey: "job") as! String)
            }
        } catch {
            print("failed")
        }
        
        do {
            let result = try context.fetch(requestOut)
            for data in result as! [NSManagedObject] {
                allOut.append(data.value(forKey: "time") as! Date)
                outJobs.append(data.value(forKey: "job") as! String)
            }
        } catch {
            print("failed")
        }
    }
    
    func parseData() {
        for item in 0...(allIn.count-1) {
            if allIn[item] < incomingData.fromDate || allIn[item] > incomingData.toDate {
                continue
            } else {
                totalHours += (allOut[item].timeIntervalSince(allIn[item]) / 3600)
            }
        }
    }
    
        
}
