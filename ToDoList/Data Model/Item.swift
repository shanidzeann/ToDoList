//
//  Item.swift
//  ToDoList
//
//  Created by Анна Шанидзе on 24.08.2021.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    @objc dynamic var dateCreated: Date?
    
}
