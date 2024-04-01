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
        
        view.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)

        // title.
        title = "Shopping List"
        // the add Button.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForList))
        // the refresh Button.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startShopping))
    }
    
    // when the user Pressed on Add Button, That code will work.
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
        // reload the data, to show the last submission.
        tableView.reloadData()
    }
    
    // for refresh Button.
    @objc func startShopping() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    // specifies the number of rows.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    // to displays the items in the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for:  indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        // background of the cell.
        cell.backgroundColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)

        // Create and configure the remove button.
        let removeButton = UIButton(type: .system)
        removeButton.setTitle("Remove", for: .normal)
        removeButton.setTitleColor(.red, for: .normal) // Set button title color to red
        removeButton.sizeToFit() // Adjust button size to fit the title
        removeButton.addTarget(self, action: #selector(removeItem(_:)), for: .touchUpInside)
        
        // Set the button as the accessory view of the cell.
        cell.accessoryView = removeButton
        
        return cell
    }
    
    @objc func removeItem(_ sender: UIButton) {
        // Get the cell containing the button that was tapped.
        guard let cell = sender.superview as? UITableViewCell else {
            return
        }
        
        // Get the index path of the cell.
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        // Remove the item from the shopping list array.
        shoppingList.remove(at: indexPath.row)
        
        // Reload the table view to reflect the changes.
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the tapped row.
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the selected cell.
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        // Toggle the editing mode of the selected cell.
        cell.setEditing(!cell.isEditing, animated: true)
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // Set the editing style for the cell to .delete.
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from the shopping list array.
            shoppingList.remove(at: indexPath.row)
            
            // Delete the row from the table view.
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


