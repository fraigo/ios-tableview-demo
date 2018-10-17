//
//  EmojiTableViewCell.swift
//  ios-tableview-demo
//
//  Created by Francisco on 2018-10-16.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(with item: TableItem){
        nameLabel.text = item.title
        descLabel.text = item.description
        symbolLabel.text = item.symbol
        downloadImage(from: item.imageUrl, intoImage: iconImage)
        
    }
    
    
    func downloadImage(from imageUrl: String, intoImage: UIImageView) {
        let url = NSURL(string: imageUrl)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                print("Error for \(imageUrl)")
                print(error!)
            } else {
                if let usableData = data {
                    DispatchQueue.main.async() {
                        intoImage.image = UIImage(data: usableData)
                    }
                }else{
                    print("No data for \(imageUrl)")
                }
            }
        }).resume()
    }

}
