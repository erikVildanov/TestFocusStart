//
//  TableViewCellNetwork.swift
//  TestFocusStart
//
//  Created by Эрик Вильданов on 06.03.17.
//  Copyright © 2017 Эрик Вильданов. All rights reserved.
//

import UIKit

class TableViewCellNetwork: TableViewCell {

    let imageSocial = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imageSocial)
        imageSocial.translatesAutoresizingMaskIntoConstraints = false
        imageSocial.contentMode = .scaleAspectFill
        
        let viewsDict = [
            "date" : date,
            "title" : title,
            "imageSocial" : imageSocial
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-3-[imageSocial(70)]-(>=10)-[date]-3-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-3-[imageSocial(70)]-10-[title]-3-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-3-[date]-3-[title]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-3-[imageSocial]-3-|", options: [], metrics: nil, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        date.text = nil
        title.text = nil
        imageSocial.image = nil
    }
}
