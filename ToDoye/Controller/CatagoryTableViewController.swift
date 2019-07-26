//
//  CatagoryTableViewController.swift
//  ToDoye
//
//  Created by Soni Suman on 7/26/19.
//  Copyright © 2019 Soni Suman. All rights reserved.
//

import UIKit
import CoreData

class CatagoryTableViewController: UITableViewController {

  var itemArr = [Catagory]()
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
      let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      print(filePath)
      loadItems()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArr.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "catagoryCell", for: indexPath)
       cell.textLabel?.text = itemArr[indexPath.row].name
        return cell
    }
 

 
  @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add new todoey items", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add item", style: .default) { (action) in
      print("Success!!!")
      let item = Catagory(context: self.context)
      item.name = textField.text!
      self.itemArr.append(item)
      self.saveData()
     self.loadItems()
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
    do {
      try context.save()
    }catch {
      print("Error save data\(error.localizedDescription)")
    }
    self.tableView.reloadData()
  }
  
  func loadItems() {
    let request :NSFetchRequest<Catagory> = Catagory.fetchRequest()
    do {
      itemArr = try context.fetch(request)
    } catch {
      print("error occured--\(error.localizedDescription)")
    }
    tableView.reloadData()
  }
  
}
