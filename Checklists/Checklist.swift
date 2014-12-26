//
//  Checklist.swift
//  Checklists
//
//  Created by Atikur Rahman on 12/25/14.
//  Copyright (c) 2014 Atikur Rahman. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    var name: String = ""
    var items: [ChecklistItem] = []
    
    func countUncheckedItems() -> Int {
        var count = 0
        
        for item in items {
            if !item.checked {
                count++
            }
        }
        
        return count
    }
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as String
        items = aDecoder.decodeObjectForKey("Items") as [ChecklistItem]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
    }
}