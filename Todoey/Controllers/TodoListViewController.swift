//
//  ViewController.swift
//  Todoey
//
//  Created by Jonathan Green on 10/20/18.
//  Copyright © 2018 Jonathan Green. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
//    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    var itemArray = [Item]()

// Go back to Quizzler module to get a solid understanding of what we're doing here with the Model/View/Controller
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        

        
        
        
    if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
     }
      
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
       
        cell.textLabel?.text = item.title

//Ternary Operator ==>
// value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//  Let's replace the code below with the Ternary Operator
 /*     if item.done == true {
         cell.accessoryType = .checkmark
        } else {
         cell.accessoryType = .none
        }
 */
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    // Gets fired whenever we click on any cell in the TableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
 /*    The part included in this comment is replaced more elegantly with the above line of code.
         if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false
        }
   */
      //  if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
      //  tableView.cellForRow(at: indexPath)?.accessoryType = .none
      //  } else {
      //  tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
      //  }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}
/*
class item: UITableViewController {
    
    var title: String = "Find Mike"
    var done: Bool = true
    
}
 This was my poor attempt at the challenge to create a new class with two properties - one called "Title" which will contain the things to do, and one called "Done" - a boolean saying if the thing is done or not.
 It wasn't really that far off - should have created a new file and it should look like this:
 
 class Item  {
 var title: String = ""
 var done: Bool = false
 }
*/
