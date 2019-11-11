//
//  ViewController.swift
//  Palvi_c0762152_note_p1
//
//  Copyright © 2019 Palvi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var arrayFolders = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Folders"
    }
    
    @IBAction func createNewFolder(_ sender: Any) {
        let alertController = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Name"
        }
        let saveAction = UIAlertAction(title: "Add Item", style: .default, handler: { alert -> Void in
            let nameTextField = alertController.textFields![0] as UITextField
            guard let folderName = nameTextField.text else {
                return
            }
            
            self.arrayFolders.append(folderName)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func startEditing(_ sender: Any) {
        guard let editButton = sender as? UIBarButtonItem else {
            return
        }
        
        editButton.title = editButton.title == "Edit" ? "Done" : "Edit"
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        cell.imageView?.image = UIImage(named: "folder")
        cell.textLabel?.text = arrayFolders[indexPath.row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayFolders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing{
            return .none
        }
        else{
            return .delete
        }
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let folderToMove = arrayFolders[sourceIndexPath.row]
        
        arrayFolders.insert(folderToMove, at: destinationIndexPath.row)
        arrayFolders.remove(at: sourceIndexPath.row)
    }
}

