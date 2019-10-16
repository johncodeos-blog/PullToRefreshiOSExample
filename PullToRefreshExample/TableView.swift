//
//  ViewController.swift
//  PullToRefreshExample
//
//  Created by John Codeos on 17/10/2019.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class TableView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var refControl = UIRefreshControl()
    
    var itemsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refControl.tintColor = UIColor.white
        refControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refControl)
        
        loadData()
    }
    
    func loadData() {
        for i in 0...40 {
            itemsArray.append("Item \(40-i)")
        }
        self.tableView.reloadData()
    }

    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        DispatchQueue.global().async {
            // fake background loading task
            sleep(2)
            DispatchQueue.main.async {
                let start = self.itemsArray.count
                let end = self.itemsArray.count + 20
                for i in start..<end {
                    self.itemsArray.insert("Item \(i)", at: 0)
                }
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as! TableViewCell
        cell.itemLabel.text = itemsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}

