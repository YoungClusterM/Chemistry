//
//  MasterAtomsViewController.swift
//  Chemistry
//
//  Created by Паша Косило on 3/17/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import UIKit
import BLTNBoard

class MasterAtomsViewController: UITableViewController, UISearchResultsUpdating {
    
    var detailViewController: DetailViewController? = nil
    var objects = [String]()
    
    var searchController = UISearchController()
    var filteredAtoms: [String] = []
    
    lazy var descriptor: BLTNItemManager = {
        let page = BLTNPageItem(title: "Atoms")
        
        page.descriptionText = "Here you can read information about all atoms from Wikipedia."
        page.actionButtonTitle = "Close"
        page.requiresCloseButton = false
        
        page.actionHandler = { (item: BLTNActionItem) in
            item.manager!.dismissBulletin(animated: true)
        }
        
        return BLTNItemManager(rootItem: page)
    }()
    
    let userDefaults = UserDefaults(suiteName: "Chemistry")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        insertAtoms(self)
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        tableView.reloadData()
        
        if (!(userDefaults?.bool(forKey: "atoms_descripted") ?? false)) {
            descriptor.showBulletin(above: UIApplication.shared.keyWindow!.rootViewController!)
            userDefaults?.set(true, forKey: "atoms_descripted")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    @objc
    func insertAtoms(_ sender: Any) {
        for atom in Atoms {
            objects.insert(atom.key, at: 0)
        }
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object: String
                if searchController.isActive {
                    object = filteredAtoms[indexPath.row]
                } else {
                    object = objects[indexPath.row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredAtoms.count
        }
        
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object: String
        if searchController.isActive {
            object = filteredAtoms[indexPath.row]
        } else {
            object = objects[indexPath.row]
        }
        cell.textLabel!.text = object.description
        cell.detailTextLabel!.text = Atoms[object.description]!.wikipedia
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredAtoms.removeAll(keepingCapacity: false)
        
        let array = (objects as Array).filter({atom -> Bool in
            return atom.lowercased().contains(searchController.searchBar.text!.lowercased())
        }) // Symbols
        let array2 = (objects as Array).filter({atom -> Bool in
            return Atoms[atom]!.wikipedia.lowercased().contains(searchController.searchBar.text!.lowercased())
        }) // Names
        
        filteredAtoms = array + array2
        
        self.tableView.reloadData()
    }
}
