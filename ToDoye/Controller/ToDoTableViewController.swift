//
//  ViewController.swift
//  ToDoye
//
//  Created by Soni Suman on 7/19/19.
//  Copyright © 2019 Soni Suman. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
  //let userDefault = UserDefaults.standard
  var itemArr = [Item]()
  let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadItems()
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
    saveData()
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
      self.saveData()
    }
    alert.addTextField(configurationHandler: { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    })
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  
  //Mark: Model menupulation method
  
  func saveData() {
    let encoder = PropertyListEncoder()
    do {
      let items = try encoder.encode(itemArr)
      try items.write(to: filePath!)
    }catch {
      print(error.localizedDescription)
    }
    self.tableView.reloadData()
  }
  
  func loadItems() {
    if let data = try? Data(contentsOf: filePath!) {
      let decoder = PropertyListDecoder()
      do {
       itemArr =  try decoder.decode([Item].self, from: data)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}




