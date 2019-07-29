//
//  ViewController.swift
//  ToDoye
//
//  Created by Soni Suman on 7/19/19.
//  Copyright © 2019 Soni Suman. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {
  
  
  @IBOutlet var searchBar: UISearchBar!
  var itemArr = [Item]()
  var selectedCategory : Catagory? {
    didSet {
      loadItems()
    }
  }
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    print(filePath)
    searchBar.delegate = self
    searchBar.resignFirstResponder()
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
    //     context.delete(itemArr[indexPath.row])
    //     itemArr.remove(at: indexPath.row)
    // itemArr[indexPath.row].setValue("Completed", forKey: "title")
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
      let item = Item(context: self.context)
      item.title = textField.text!
      item.done = false
      item.parentItem = self.selectedCategory
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
    do {
      try context.save()
    }catch {
      print("Error save data\(error.localizedDescription)")
    }
    self.tableView.reloadData()
  }
  
  func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),predicate: NSPredicate? = nil) {
    let tempPredicate = NSPredicate(format: "parentItem.name MATCHES %@", selectedCategory!.name!)
    if  let categoryPredicate = predicate {
      request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,tempPredicate])
    }
    else {
      request.predicate = tempPredicate
    }
    
    do {
      itemArr = try context.fetch(request)
    } catch {
      print("error occured--\(error.localizedDescription)")
    }
  }
}
extension ToDoTableViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    loadItems(with: request , predicate: request.predicate!)
  }
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    loadItems()
    DispatchQueue.main.async {
      searchBar.resignFirstResponder()
    }
  }
  
}






