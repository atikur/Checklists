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
    var iconName: String
    
    func countUncheckedItems() -> Int {
        var count = 0
        
        for item in items {
            if !item.checked {
                count++
            }
        }
        
        return count
    }
    
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as String
        items = aDecoder.decodeObjectForKey("Items") as [ChecklistItem]
        iconName = aDecoder.decodeObjectForKey("IconName") as String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
        aCoder.encodeObject(iconName, forKey: "IconName")
    }
}