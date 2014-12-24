//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Atikur Rahman on 12/23/14.
//  Copyright (c) 2014 Atikur Rahman. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        let item = ChecklistItem()
        item.text = textField.text
        
       delegate?.addItemViewController(self, didFinishAddingItem: item)
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        
        doneBarButton.enabled = false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var oldText: NSString = textField.text
        var newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = newText.length > 0
        return true
    }

}
