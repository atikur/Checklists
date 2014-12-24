//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Atikur Rahman on 12/23/14.
//  Copyright (c) 2014 Atikur Rahman. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}