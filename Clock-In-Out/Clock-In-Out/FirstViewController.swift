//
//  FirstViewController.swift
//  Clock-In-Out
//
//  Created by Robin Lopez Ordonez on 3/3/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    var allIn = [Date]()
    var allOut = [Date]()
    var inJobs = [String]()
    var outJobs = [String]()
    let timeformat = DateFormatter()
    let dateformat = DateFormatter()
    var shifts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = .lightGray
        timeformat.dateFormat = "h:mm a"
        dateformat.dateStyle = .short
        getData()
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
    
    @IBAction func clearTapper(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let requestIn = NSFetchRequest<NSFetchRequestResult>(entityName: "ClockIn")
        let requestOut = NSFetchRequest<NSFetchRequestResult>(entityName: "ClockOut")
        requestIn.returnsObjectsAsFaults = false
        requestOut.returnsObjectsAsFaults = false
        
        let deleteIn = NSBatchDeleteRequest(fetchRequest: requestIn)
        let deleteOut = NSBatchDeleteRequest(fetchRequest: requestOut)
        
        do {
            try context.execute(deleteIn)
        } catch {
            print("error")
        }
        
        do {
            try context.execute(deleteOut)
        } catch {
            print("error")
        }
        
        mainTable.reloadData()
    }
    
}

//MARK: TableView Cell Formatting
extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(allIn.count,allOut.count) - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if inJobs[indexPath.row] == outJobs[indexPath.row] {
            cell.textLabel?.text = "Shift: \(dateformat.string(from: allIn[indexPath.row])) from \(timeformat.string(from: allIn[indexPath.row])) to \(timeformat.string(from: allOut[indexPath.row])) for \(inJobs[indexPath.row])"
        } else {
            cell.textLabel?.text = "Error"
        }
        
        return cell
    }
}

