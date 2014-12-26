//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Atikur Rahman on 12/25/14.
//  Copyright (c) 2014 Atikur Rahman. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    
    // MARK: -
    // MARK: TableView data source and delegate methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel?.text = checklist.name
        cell.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
        
        if checklist.items.isEmpty {
            cell.detailTextLabel?.text = "(No Items)"
        } else {
            cell.detailTextLabel?.text = checklist.countUncheckedItems() > 0 ? "\(checklist.countUncheckedItems()) Remaining" : "All Done!"
        }
        
        cell.imageView?.image = UIImage(named: checklist.iconName)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.indexOfSelectedChecklist = indexPath.row
        
        let checklist = dataModel.lists[indexPath.row]
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.lists.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard?.instantiateViewControllerWithIdentifier("ListNavigationController") as UINavigationController
        let controller = navigationController.topViewController as ListDetailViewController
        controller.delegate = self
        
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    // MARK: -
    // MARK: ListDetailViewControllerDelegate methods
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist) {
        dataModel.lists.append(checklist)
        dataModel.sortChecklists()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist) {
        dataModel.sortChecklists()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: -
    // MARK: UINavigationControllerDelegate methods
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }
    
    // MARK: -
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = dataModel.indexOfSelectedChecklist
        
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegueWithIdentifier("ShowChecklist", sender: checklist)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destinationViewController as ChecklistViewController
            controller.checklist = sender as Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
