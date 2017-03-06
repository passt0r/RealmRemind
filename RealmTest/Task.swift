//
//  Task.swift
//  RealmTest
//
//  Created by Dmytro Pasinchuk on 05.03.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
    dynamic var tastName = ""
    dynamic var beginDate = NSDate()
    dynamic var taskNotes = ""
    dynamic var isDone = false
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

class TaskList: Object {
    
    dynamic var listName = ""
    dynamic var creatingDate = NSDate()
    let tasks = List<Task>()
    
}
