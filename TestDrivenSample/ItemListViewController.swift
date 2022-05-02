//
//  ItemListViewController.swift
//  TestDrivenSample
//
//  Created by Arrr Park on 2022/05/01.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
