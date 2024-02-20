//
//  ViewController.swift
//  Exercise6
//
//  Created by user237599 on 2/19/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var itemList: [String] = []
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var listTable: UITableView!
    
    
    @IBAction func addButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
           
           alert.addTextField { (textField) in
               textField.placeholder = "Write an Item"
           }
           
           alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
               alert?.dismiss(animated: true)
           }))
           
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
               let textField = alert?.textFields![0]
               if let newItem = textField?.text, !newItem.isEmpty {
                   self.itemList.append(newItem)
                   self.saveItems()
                   self.listTable.reloadData()
               }
           }))
           
           self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTable.dataSource = self
        listTable.delegate = self
        getItemsFromLocalStorage()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    
    //To Display All Items in Table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row]
        return cell
    }
    
    
    //To Delete an Item from List
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedItemIndex = indexPath.row
            itemList.remove(at: deletedItemIndex)
            saveItems()
            
            let indexPathToDelete = IndexPath(row: deletedItemIndex, section: 0)
            listTable.deleteRows(at: [indexPathToDelete], with: .automatic)
        }
    }


    //To Save the Item to Local storage
    func saveItems() {
         userDefaults.set(itemList, forKey: "SavedItems")
     }
    
    //To Retrieve Items from Local storage
    func getItemsFromLocalStorage() {
         if let savedItems = userDefaults.array(forKey: "SavedItems") as? [String] {
             itemList = savedItems
         } else {
             itemList = ["Item 1","Item 2","Item 3","Item 4","Item 5","Item 6","Item 7","Item 8"]
         }
     }
}

