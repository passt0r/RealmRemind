//
//  TaskListTableViewController.swift
//  RealmTest
//
//  Created by Dmytro Pasinchuk on 05.03.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListTableViewController: UITableViewController {
    @IBOutlet weak var addTaskButton: UINavigationItem!
    var newListItem: String? {
        didSet {
            print("new value set: \(newListItem))")
        }
    }
    let realm = try! Realm()
    var availableTasks: Results<TaskList>? = nil
    
    func sampleAdding() {
        let sampleTask = TaskList()
        sampleTask.listName = "Test"
        sampleTask.creatingDate = NSDate()
        try! realm.write {
            realm.add(sampleTask)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       // sampleAdding()
        
        let currentTaskList = realm.objects(TaskList.self)
        availableTasks = currentTaskList
        
        navigationItem.leftBarButtonItem = editButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let availableTask = availableTasks {
            return availableTask.count
        } else {
        return 1
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) { //create new instance if alert and then create new instance in Realm using this data
        let addingList = UIAlertController(title: "Adding new task list", message: "Add new task list name:", preferredStyle: .alert)
        addingList.addTextField(configurationHandler: nil)
        let allertAction = UIAlertAction(title: "Ok", style: .default, handler: {
            alert in self.newListItem = addingList.textFields!.first!.text
            if let newItem = self.newListItem {
                let newItemToAdd = TaskList()
                newItemToAdd.listName = newItem
                newItemToAdd.creatingDate = NSDate()
                try! self.realm.write {
                    self.realm.add(newItemToAdd)
                    self.tableView.reloadData()
                }
            }
        })
        addingList.addAction(allertAction)
        self.present(addingList, animated: true, completion: nil)
        
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListMember", for: indexPath) as! ListedTaskTableViewCell

        // Configure the cell...
        guard let currentTasksList = availableTasks else { fatalError("Can't read realm or data is empty")}
        cell.taskListName.text = currentTasksList[indexPath.row].listName
        cell.tasksLeft.text = String(currentTasksList[indexPath.row].tasks.count)

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletingObject = availableTasks![indexPath.row]
            try! realm.write {
                realm.delete(deletingObject)
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowTasksAtList" {
            let destinationNavController = segue.destination as! UINavigationController
            let destinationController = destinationNavController.topViewController as! TasksTableViewController
            let senderBar = sender as! ListedTaskTableViewCell
            let senderIndex = tableView.indexPath(for: senderBar)!.row
            destinationController.currentTaskList = availableTasks![senderIndex]
            
        } else {
            fatalError("Unexpected segue beheviour")
        }
    }
    

}
