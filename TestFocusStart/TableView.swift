//
//  TableView.swift
//  TestFocusStart
//
//  Created by Эрик Вильданов on 06.03.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class TableView: UIView {

    var tableView = UITableView()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        initializeView()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableViewAutomaticDimension
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: ["tableView": tableView ]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: ["tableView": tableView ]))
    }

}
