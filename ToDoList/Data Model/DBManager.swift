//
//  DBManager.swift
//  ToDoList
//
//  Created by Anna Shanidze on 12.12.2021.
//

import Foundation
import RealmSwift

class DBManager {
    
    static let shared = DBManager()
    
    let realm = try! Realm()
    var categories: Results<Category>?
    var toDoItems: Results<Item>?
    
    
    // MARK: - Category
    
    var selectedCategory: Category? {
        didSet {
            loadItems(completion: nil)
        }
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
    }
    
    func save(category: Category, completion: @escaping (Bool) -> Void) {
        do {
            try realm.write({
                realm.add(category)
                completion(true)
            })
        } catch {
            print("Error saving category \(error)")
            completion(false)
        }
        
    }
    
    func delete(at indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        if let category = self.categories?[indexPath.row] {
            do {
                try self.realm.write({
                    self.realm.delete(category)
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    
                })
            } catch {
                print("Error deleting category \(error)")
                completion(false)
            }
        }
    }
    
    
    // MARK: - Item
    
    func loadItems(completion: (() -> Void)?) {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        completion?()
    }
    
    func toggleCompletion(at indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status \(error)")
            }
        }
    }
    
    func addItem(_ title: String) {
        if let currentCategory = selectedCategory {
            do {
                try self.realm.write({
                    let newItem = Item()
                    newItem.title = title
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                })
            } catch {
                print("Error saving new item \(error)")
            }
        }
    }
    
    func deleteItem(at indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
                try self.realm.write({
                    self.realm.delete(item)
                })
            } catch {
                print("Error deleting item \(error)")
            }
        }
    }
    
}
