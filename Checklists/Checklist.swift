//
//  Checklist.swift
//  Checklists
//
//  Created by Atikur Rahman on 12/25/14.
//  Copyright (c) 2014 Atikur Rahman. All rights reserved.
//

import UIKit

class Checklist: NSObject{
    var name: String = ""
    var items: [ChecklistItem] = []
    
    init(name: String) {
        self.name = name
        super.init()
    }
}