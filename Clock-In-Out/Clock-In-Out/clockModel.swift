//
//  clockModel.swift
//  Clock-In-Out
//
//  Created by Robin Lopez Ordonez on 3/27/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import Foundation
import CoreData

public class clockItem:NSManagedObject, Identifiable {
    @NSManaged public var clockIn:Date?
    @NSManaged public var clockOut:Date?
}


