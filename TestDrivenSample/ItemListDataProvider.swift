//
//  ItemListDataProvider.swift
//  TestDrivenSample
//
//  Created by Arrr Park on 2022/05/01.
//

import UIKit

enum Section: Int {
    case Todo
    case Done
}

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var itemManager: ItemManager?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else { fatalError() }
        
        let numberOfRows: Int
        
        switch itemSection {
        case .Todo:
            numberOfRows = itemManager.toDoCount
        case .Done:
            numberOfRows = itemManager.doneCount
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
