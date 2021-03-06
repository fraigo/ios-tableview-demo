//
//  ViewController.swift
//  ios-tableview-demo
//
//  Created by Francisco on 2018-10-16.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Smiley", description: "A smiley face"),
        Emoji(symbol: "😉", name: "Winking", description: "A winking face")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getJsonFromUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getJsonFromUrl(){
        //creating a NSURL
        let dataURL : String = "https://api.github.com/users/fraigo/repos?sort=updated&per_page=100"
        let url = NSURL(string: dataURL)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print(error!)
            } else {
                if let usableData = data {
                    let string = String(data: usableData, encoding: String.Encoding.utf8)
                    print(string) //JSONSerialization
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSArray {
                        print(jsonObj)
                    }
                }
            }
        
                /*
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                let items = jsonObj!.allValues as! [NSObject]
                print(items.count)
                
            }
                */
        }).resume()
    }
    
    
   


}

extension TableViewController: UITableViewDelegate {
    
    
    
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let emoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(emoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        let emoji = emojis[indexPath.row]
        cell.configCell(with: emoji)
        cell.showsReorderControl = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
