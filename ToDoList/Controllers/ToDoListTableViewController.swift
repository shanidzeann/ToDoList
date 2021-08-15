//
//  ViewController.swift
//  ToDoList
//
//  Created by Анна Шанидзе on 14.08.2021.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//
//        let newItem = Item()
//        newItem.title = "Do sth"
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        itemArray.append(newItem)
//        let newItem1 = Item()
//        newItem1.title = "Do"
//        itemArray.append(newItem1)
//        itemArray.append(newItem1)
//        itemArray.append(newItem1)
//        itemArray.append(newItem1)
//        itemArray.append(newItem1)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
        
    }
    

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

   
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Add New Items
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    

}


