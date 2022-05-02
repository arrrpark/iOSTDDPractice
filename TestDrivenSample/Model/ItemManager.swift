//
//  ItemManager.swift
//  TestDrivenSample
//
//  Created by Arrr Park on 2022/05/01.
//

import Foundation

class ItemManager {
    var toDoCount = 0
    var doneCount = 0
    var todoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    func addItem(item: ToDoItem) {
        toDoCount += 1
        todoItems.append(item)
    }
    
    func itemAtIndex(_ index: Int) -> ToDoItem {
        return todoItems[index]
    }
    
    func checkItemAtIndex(_ index: Int) {
        let item = todoItems.remove(at: index)
        doneItems.append(item)
        toDoCount -= 1
        doneCount += 1
    }
    
    func doneItemAtIndex(_ index: Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func removeAllItems() {
        todoItems.removeAll()
        doneItems.removeAll()
        toDoCount = 0
        doneCount = 0
    }
}
