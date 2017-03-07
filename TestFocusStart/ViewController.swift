//
//  ViewController.swift
//  TestFocusStart
//
//  Created by Эрик Вильданов on 06.03.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    let tableView = TableView()
    let tableDataSource = TableDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableView.register(TableViewCellContent.self, forCellReuseIdentifier: "cellContent")
        tableView.tableView.register(TableViewCellSource.self, forCellReuseIdentifier: "cellSource")
        tableView.tableView.register(TableViewCellNetwork.self, forCellReuseIdentifier: "cellNetwork")
        tableView.tableView.delegate = self
        navigationItem.title = "TestFocusStart"
        loadJson{
            self.tableView.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        tableView.tableView.dataSource = tableDataSource
        view = tableView
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadJson(_ completion: ((Void) -> Void)?){
        let feedJsonParser = FeedJsonParser()
        feedJsonParser.parseFeed(completionHandler:
            {
                (json: Messages) -> Void in
                self.tableDataSource.msg = json
                DispatchQueue.main.async(execute: {
                    completion?()
                })
        })
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableDataSource.msg.type[indexPath.row] == "image" {
            
            let fullScreanViewController = FullScreanViewController()
            fullScreanViewController.image = tableDataSource.msg.source[indexPath.row].cachedImage!
            print(fullScreanViewController.image.size)
            self.navigationController?.pushViewController(fullScreanViewController, animated: false)
        }
        
        if tableDataSource.msg.type[indexPath.row] == "social" {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(tableDataSource.msg.source[indexPath.row])
            } else {
                UIApplication.shared.openURL(tableDataSource.msg.source[indexPath.row])
            }
        }
    }
    

}

