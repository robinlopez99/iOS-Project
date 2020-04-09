//
//  invoiceDataModel.swift
//  Clock-In-Out
//
//  Created by Robin Lopez Ordonez on 3/30/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import Foundation

struct invoiceData {
    var fromDate:Date
    var toDate:Date
    var hourly:Int
    var additional:Int
    var job:String
    
    init(from fromDate:Date?,to toDate:Date?,hourly:Int?,additional: Int?,job:String?) {
        
        if let fromDate = fromDate {
            self.fromDate = fromDate
        } else {
            self.fromDate = Date()
        }
        
        if let toDate = toDate {
            self.toDate = toDate
        } else {
            self.toDate = Date()
        }
        
        
        if let hourly = hourly {
            self.hourly = hourly
        } else {
            self.hourly = 0
        }
        
        
        if let additional = additional {
            self.additional = additional
        } else {
            self.additional = 0
        }
        
        
        if let job = job {
            self.job = job
        } else {
            self.job = ""
        }
    }
    
    func validJob()->Bool {
        return self.job != ""
    }
    
}
