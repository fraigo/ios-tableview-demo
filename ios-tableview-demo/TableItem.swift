//
//  TableItem.swift
//  ios-tableview-demo
//
//  Created by Francisco on 2018-10-16.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import Foundation


struct TableItem {
    var title: String
    var description: String
    var symbol: String
    var imageUrl: String
    
    init(_ item: NSDictionary) {
        title = item.value(forKey: "full_name") as! String
        description = item.value(forKey: "description") as! String
        symbol = String(item.value(forKey: "stargazers_count") as! Int)
        let owner = item.value(forKey: "owner") as! NSDictionary
        imageUrl = owner.value(forKey: "avatar_url") as! String
    }
}
