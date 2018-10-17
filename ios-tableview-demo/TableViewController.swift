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
    
    var tableData: [TableItem] = [TableItem]()
    
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
        let dataURL : String = "https://api.github.com/search/repositories?q=ios"
        let url = NSURL(string: dataURL)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print(error!)
            } else {
                if let usableData = data {
                    //self.parseString(data: usableData)
                    //self.parseArray(data: usableData)
                    self.parseDictionary(data: usableData)
                    
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
    
    func parseString(data: Data){
        let string = String(data: data, encoding: String.Encoding.utf8)
        print(string!)
        
    }
    
    func parseArray(data: Data){
        if let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray {
            for item in jsonArray {
                self.tableData.append(TableItem(item as! NSDictionary))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView.reloadData()
            }
            
        }
    }
    
    func parseDictionary(data: Data){
        if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
            let descriptor: NSSortDescriptor = NSSortDescriptor(key: "stargazers_count", ascending: false)
            if let itemArray = jsonObj!.value(forKey: "items") as? NSArray {
                let sortedResults: NSArray = itemArray.sortedArray(using: [descriptor]) as NSArray
                for item in sortedResults {
                    self.tableData.append(TableItem(item as! NSDictionary))
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    

}

extension TableViewController: UITableViewDelegate {
    
    
    
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let emoji = tableData.remove(at: sourceIndexPath.row)
        tableData.insert(emoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! DataTableViewCell
        let item = tableData[indexPath.row]
        cell.configCell(with: item)
        cell.showsReorderControl = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
