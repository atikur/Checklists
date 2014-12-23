//
//  ViewController.swift
//  Checklists
//
//  Created by Atikur Rahman on 12/22/14.
//  Copyright (c) 2014 Atikur Rahman. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var checklistItems: [ChecklistItem] = []

    @IBAction func addItem(sender: UIBarButtonItem) {
        let rowCount = checklistItems.count
        
        let item = ChecklistItem()
        item.text = "I am a new item"
        checklistItems.append(item)
        
        let indexPath = NSIndexPath(forRow: rowCount, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChecklistItems()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklistItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as UITableViewCell
        let item = checklistItems[indexPath.row]

        configureTextLabelForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = checklistItems[indexPath.row]
            item.toggleChecked()
            
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // helper methods
    
    private func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    private func configureTextLabelForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as UILabel
        label.text = item.text
    }
    
    private func addChecklistItems() {
        let item1 = ChecklistItem()
        item1.text = "Wake up"
        checklistItems.append(item1)
        
        let item2 = ChecklistItem()
        item2.text = "Have breakfast"
        checklistItems.append(item2)
        
        let item3 = ChecklistItem()
        item3.text = "Learn iOS development"
        checklistItems.append(item3)
        
        let item4 = ChecklistItem()
        item4.text = "Read newspaper"
        checklistItems.append(item4)
        
        let item5 = ChecklistItem()
        item5.text = "Have a walk"
        checklistItems.append(item5)
    }
}

