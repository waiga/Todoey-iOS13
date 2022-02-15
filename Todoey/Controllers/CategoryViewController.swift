//
//  CategoryViewController.swift
//  Todoey
//
//  Created by 김미향 on 2022/02/14.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    //read, create, load, delete, update
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategory()
        
    }
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Nil Coalescing Operator
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        //let category = categoryArray[indexPath.row]
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Add Yet"
        
        return cell
    }

    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error Saving Context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory() {
        
        categoryArray = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    //MARK: - Add new Categories
    


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: ":->", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD CATEGORY", style: .default) { action in
            
            let newCategory = Category()
            newCategory.name = textField.text!

            self.save(category: newCategory)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Category:^o"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
}
