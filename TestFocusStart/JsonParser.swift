//
//  JsonParser.swift
//  TestFocusStart
//
//  Created by Эрик Вильданов on 07.03.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//
import UIKit

class FeedJsonParser {
    
    var msg = Messages()
    
    fileprivate var parserCompletionHandler:((Messages) -> Void )?
    
    func parseFeed (completionHandler: ((Messages) -> Void)?) -> Void {
        
        self.parserCompletionHandler = completionHandler
        
        let path = Bundle.main.path(forResource: "messages", ofType: "json")
        let text = try! String(contentsOfFile: path! as String, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        
        parser(text.data(using: .utf8)!)
        
    }
    
    func parser(_ data: Data){
        
        var dateArray: [Date] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray
        
        for i in 0 ..< json.count{
            let object = json[i] as! [String: AnyObject]
            
            if let type = object["type"] {
                msg.type.append(type as! String)
            }
            if let date = object["date"] {
                msg.date.append(date as! String)
                if let d = dateFormatter.date(from: date as! String){
                dateArray.append(d)
                }
            }
            if let title = object["title"] {
                msg.title.append(title as! String)
            }
            if let content = object["content"] {
                msg.content.append(content as! String)
            } else {
                msg.content.append("")
            }
            if let source = object["source"] {
                msg.source.append(URL(string: source as! String)!)
            } else {
                msg.source.append(URL(string: "/")!)
            }
            if let network = object["network"] {
                msg.network.append(network as! String)
            } else {
                msg.network.append("")
            }
        }
        
        for i in 0..<dateArray.count - 1 {
            for j in 0..<dateArray.count - i - 1 {
                if (dateArray[j] < dateArray[j + 1]) {
                    
                    let tempType = msg.type[j]
                    let tempDate = msg.date[j]
                    let tempTitle = msg.title[j]
                    let tempContent = msg.content[j]
                    let tempsource = msg.source[j]
                    let tempNetwork = msg.network[j]
                    msg.type[j] = msg.type[j+1]
                    msg.date[j] = msg.date[j+1]
                    msg.title[j] = msg.title[j+1]
                    msg.content[j] = msg.content[j+1]
                    msg.source[j] = msg.source[j+1]
                    msg.network[j] = msg.network[j+1]
                    msg.type[j + 1] = tempType
                    msg.date[j + 1] = tempDate
                    msg.title[j + 1] = tempTitle
                    msg.content[j + 1] = tempContent
                    msg.source[j + 1] = tempsource
                    msg.network[j + 1] = tempNetwork
                    
                    let temp = dateArray[j];
                    dateArray[j] = dateArray[j + 1];
                    dateArray[j + 1] = temp;
                }
            }
        }
        
        dateArray.removeAll()
        
        parserCompletionHandler?(msg)
    }
    
}

