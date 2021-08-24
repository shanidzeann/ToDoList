//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by Анна Шанидзе on 20.08.2021.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        
     //   cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
//        self.saveCategories()
//
//        tableView.reloadData()
//
//        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListTableViewController
        
            if let indexPath = tableView.indexPathForSelectedRow {
    
            destinationVC.selectedCategory = categories?[indexPath.row]
    
            }
    
    }
    
    
    // MARK: - Add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
//            self.categoryArray.append(newCategory)
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Data manipulation methods
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
  //      with request: NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
        tableView.reloadData()
    }
    
    
    func save(category: Category) {
        
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    
    }

    
}
