//
//  TasksTableViewController.swift
//  RealmTest
//
//  Created by Dmytro Pasinchuk on 05.03.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import RealmSwift

class TasksTableViewController: UITableViewController {
    @IBOutlet weak var taskNavName: UINavigationItem!
    var currentTaskList = TaskList()
    var newItem: String?
    let realm = try! Realm()

    @IBAction func touchForExit(_ sender: Any) {
        print("touch detect")
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem //for test period
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
        // #warning Incomplete implementation, return the number of rows
        return currentTaskList.tasks.count
    }

    
    @IBOutlet weak var addTask: UIBarButtonItem!
    @IBAction func addTaskButtonPressed(_ sender: UIBarButtonItem) {
        let addingList = UIAlertController(title: "Adding new task", message: "Add new task name:", preferredStyle: .alert)
        addingList.addTextField(configurationHandler: nil)
        addingList.addTextField(configurationHandler: {textField in textField.placeholder = "Enter comments to your task"})
        let allertAction = UIAlertAction(title: "Ok", style: .default, handler: {
            alert in self.newItem = addingList.textFields!.first!.text
            if let newItem = self.newItem {
                let newItemToAdd = Task()
                newItemToAdd.tastName = newItem
                newItemToAdd.taskNotes = addingList.textFields![1].text!
                newItemToAdd.beginDate = NSDate()
                newItemToAdd.isDone = false
                try! self.realm.write {
                    self.currentTaskList.tasks.append(newItemToAdd)
                    self.realm.add(newItemToAdd)
                    self.tableView.reloadData()
                }
            }
            
        })
        addingList.addAction(allertAction)
        self.present(addingList, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentTask", for: indexPath) as! ListedTaskItemTableViewCell
        let currentTask = currentTaskList.tasks[indexPath.row]
        
        cell.taskName.text = currentTask.tastName
        cell.isDoneLabel.text = String(currentTask.isDone)
        if (currentTask.isDone) {
            cell.taskIsDone.image = UIImage(named: "done")
            let date = currentTaskList.tasks[indexPath.row].beginDate
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd.MM.yy"
            dateFormat.timeStyle = .short
            let timeresult = dateFormat.string(from: date as Date)
            
            cell.isDoneLabel.text = String("End at \(timeresult)")
            
        } else {
            cell.taskIsDone.image = UIImage(named: "not_done")
            let date = currentTaskList.tasks[indexPath.row].beginDate
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd.MM.yy"
            dateFormat.timeStyle = .short
            let timeresult = dateFormat.string(from: date as Date)

            cell.isDoneLabel.text = String("Start at \(timeresult)")
        }

        // Configure the cell...

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = currentTaskList.tasks[indexPath.row]
        let selectedRow = tableView.cellForRow(at: indexPath) as! ListedTaskItemTableViewCell
        try! realm.write {
            if (selectedTask.isDone) {
                selectedRow.taskIsDone.image = UIImage(named: "not_done")
                selectedTask.isDone = false
                selectedTask.beginDate = NSDate()
            } else {
                selectedRow.taskIsDone.image = UIImage(named: "done")
                selectedTask.isDone = true
                selectedTask.beginDate = NSDate()
            }
            tableView.reloadData()
        }
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let deletingItem = currentTaskList.tasks[indexPath.row]
            try! realm.write {
                realm.delete(deletingItem)
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
