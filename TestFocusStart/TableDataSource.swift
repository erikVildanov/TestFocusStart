//
//  TableDataSource.swift
//  TestFocusStart
//
//  Created by Эрик Вильданов on 07.03.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class TableDataSource: NSObject ,UITableViewDataSource, URLSessionDelegate {
    
    var msg = Messages()
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return msg.type.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if msg.type[indexPath.row] == "text" {
            let cellContent = tableView.dequeueReusableCell(withIdentifier: "cellContent", for: indexPath) as! TableViewCellContent
            
            cellContent.date.text = msg.date[indexPath.row]
            cellContent.title.text = msg.title[indexPath.row]
            cellContent.content.text = msg.content[indexPath.row]
            
            return cellContent
        } else if msg.type[indexPath.row] == "image" {
            
            let cellSource = tableView.dequeueReusableCell(withIdentifier: "cellSource", for: indexPath) as! TableViewCellSource
            
            cellSource.date.text = msg.date[indexPath.row]
            cellSource.title.text = msg.title[indexPath.row]
            
            cellSource.imageURl = msg.source[indexPath.row] as NSURL
            
                if let image = msg.source[indexPath.row].cachedImage {
                    cellSource.imageSource.image = image
                } else {
                    msg.source[indexPath.row].fetchImage { img in
                        if cellSource.imageURl as URL == self.msg.source[indexPath.row] {
                            cellSource.imageSource.image = img
                        }
                    }
                }
        
            return cellSource
        } else {
            let cellNetwork = tableView.dequeueReusableCell(withIdentifier: "cellNetwork", for: indexPath) as! TableViewCellNetwork
            
            cellNetwork.date.text = msg.date[indexPath.row]
            cellNetwork.title.text = msg.title[indexPath.row]
            
            if msg.network[indexPath.row] == "twitter" {
                cellNetwork.imageSocial.image = UIImage(named: "Twitter")
                
            } else if msg.network[indexPath.row] == "facebook" {
                cellNetwork.imageSocial.image = UIImage(named: "Facebook")
            } else {
                cellNetwork.imageSocial.image = UIImage(named: "VKontakte")
            }
            
            return cellNetwork
        }

    }
}

extension String {
    func appendingPathComponent(_ string: String) -> String {
        return URL(fileURLWithPath: self).appendingPathComponent(string).path
    }
}
