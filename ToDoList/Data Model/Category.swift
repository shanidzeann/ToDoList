//
//  Category.swift
//  ToDoList
//
//  Created by Анна Шанидзе on 24.08.2021.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<Item>()
}
