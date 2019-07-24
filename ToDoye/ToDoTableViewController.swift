//
//  ViewController.swift
//  ToDoye
//
//  Created by Soni Suman on 7/19/19.
//  Copyright © 2019 Soni Suman. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
  let userDefault = UserDefaults.standard
  var itemArr = [Item]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let item = Item()
    item.title = "Buy Eggs"
    itemArr.append(item)
    
    let item1 = Item()
    item1.title = "Buy Vegitable"
    itemArr.append(item1)
    
    let item2 = Item()
    item2.title = "Buy milk"
    itemArr.append(item2)
    
    let item3 = Item()
    item3.title = "Buy Bread"
    itemArr.append(item3)
    if let items = userDefault.array(forKey: "TodoListItems") as? [Item] {
      itemArr = items
    }
  }
  
  //Mark: Tableview Datasource Delegates
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableCell", for: indexPath)
    let item = itemArr[indexPath.row]
    cell.textLabel?.text = item.title
    cell.accessoryType  = item.done ? .checkmark : .none
    return cell
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArr.count
  }
  
  //Mark: Tableview delegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
    print(itemArr[indexPath.row])
    itemArr[indexPath.row].done = !itemArr[indexPath.row].done
    tableView.reloadData()
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // Mark: Add new items
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add new todoey items", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add item", style: .default) { (action) in
      print("Success!!!")
      let item = Item()
      item.title = textField.text!
      self.itemArr.append(item)
      self.userDefault.set(self.itemArr, forKey: "TodoListItems")
      
      self.tableView.reloadData()
    }
    alert.addTextField(configurationHandler: { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    })
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  
}




