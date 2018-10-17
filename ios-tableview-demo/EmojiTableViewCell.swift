//
//  EmojiTableViewCell.swift
//  ios-tableview-demo
//
//  Created by Francisco on 2018-10-16.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(with emoji: Emoji){
        nameLabel.text = emoji.name
        descLabel.text = emoji.description
        symbolLabel.text = emoji.symbol
    }
    
    
    

}
