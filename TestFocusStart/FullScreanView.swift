//
//  FullScreanView.swift
//  TestFocusStart
//
//  Created by Эрик Вильданов on 07.03.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class FullScreanView: UIView {

    let imageView = UIImageView()
    let scrollView = UIScrollView()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        initializeView()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView(){
        addSubview(scrollView)
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let viewsDict = ["scrollView" : scrollView] as [String : Any]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: viewsDict))
        scrollView.addSubview(imageView)
        imageView.backgroundColor = UIColor.yellow
        
    }

    
}
