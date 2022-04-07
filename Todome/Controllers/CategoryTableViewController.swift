//
//  CategoryTableViewController.swift
//  Todome
//
//  Created by Andrey Khakimov on 07.04.2022.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    
    
    
    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    // MARK: - Data Manipulation Methods
    
    private func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching categories data from context \(error)")
        }
    }
    
    private func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
    }
    // MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { [unowned self] _ in
            
            let newCategory = Category(context: context)
            newCategory.name = textField.text!
            
            categories.append(newCategory)
            
            saveCategories()
            
            self.tableView.reloadData()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addTextField { alertTF in
            alertTF.placeholder = "Create a new Category"
            textField = alertTF
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
