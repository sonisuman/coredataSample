//
//  ViewController.swift
//  ToDoye
//
//  Created by Soni Suman on 7/19/19.
//  Copyright © 2019 Soni Suman. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {

  var itemArr = ["Buy Eggs", "Buy Vegitable","Buy milk"]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
 //Mark: Tableview Datasource Delegates
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableCell", for: indexPath)
    cell.textLabel?.text = itemArr[indexPath.row]
    //cell.accessoryType = .checkmark
    return cell
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArr.count
  }

  //Mark: Tableview delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print(indexPath.row)
     print(itemArr[indexPath.row])
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark  {
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
    } else {
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // Mark: Add new items
  
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add new todoey items", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add item", style: .default) { (action) in
      print("Success!!!")
     self.itemArr.append(textField.text!)
      self.tableView.reloadData()
    }
    alert.addTextField(configurationHandler: { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
      print(alertTextField.text)
    })
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  

}




