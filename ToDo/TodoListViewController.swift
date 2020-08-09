//
//  TodoListViewController.swift
//  ToDo
//
//  Created by nyagoro on 2020/08/09.
//  Copyright © 2020 Nyago. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Todoを追加", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "リストに追加", style: .default) { (action) in
            let newItem: Item = Item(title: textField.text!)
            self.itemArray.append(newItem)
            self.tableView.reloadData()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "新しいアイテム"
            textField = alertTextField
        }

        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    class Item {
        var title : String
        var done: Bool = false

        init(title: String) {
            self.title = title
        }
    }
    
    var itemArray: [Item] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        let item1: Item = Item(title: "宿題をする")
        let item2: Item = Item(title: "牛乳を買う")
        let item3: Item = Item(title: "手紙を書く")
        
        itemArray.append(item1)
        itemArray.append(item2)
        itemArray.append(item3)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemArray.count

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        item.done = !item.done
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        itemArray.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)

    }
}

