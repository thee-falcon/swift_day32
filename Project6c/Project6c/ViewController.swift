//
//  ViewController.swift
//  Project6c
//
//  Created by Omar Makran on 3/31/24.
//  Copyright © 2024 Omar Makran. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // Array to store all the items the user wants to buy.
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title.
        title = "Shoppping List"
        // the add Button.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForList))
        // the refresh Button.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startShopping))
          
    }
    
    // when the user Pressed om Add Button, That code will working.
    @objc func promptForList() {
        let ac = UIAlertController(title: "Enter your Order", message: nil, preferredStyle: .alert)
        
        // let the user to input the text.
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    // to store the Shopping List in the array.
    func submit(_ item: String)  {
        let newItem = item.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // is not empty if is empty return.
        guard !newItem.isEmpty else {
            return
        }
        
        shoppingList.insert(newItem, at: 0)
        // reload the data, to show the last submition.
        tableView.reloadData()
    }
    
    // for refresh Button.
    @objc func startShopping() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    // spicifies the number of rows.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    // to show the result.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for:  indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

