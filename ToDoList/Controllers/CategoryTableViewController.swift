//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Анна Шанидзе on 20.08.2021.
//

import UIKit


class CategoryTableViewController: SwipeTableViewController {
    
    let db = DBManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.loadCategories()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.categories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = db.categories?[indexPath.row].name ?? ""
        return cell
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        db.selectedCategory = db.categories?[indexPath.row]
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    // MARK: - Add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.db.save(category: newCategory) { succeded in
                if succeded {
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delete data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        db.delete(at: indexPath) { succeded in
            if succeded {
                self.tableView.reloadData()
            }
        }
    }
    
    
}
