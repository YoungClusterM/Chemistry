//
//  MasterAtomsViewController.swift
//  Chemistry
//
//  Created by Паша Косило on 3/17/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import UIKit
import BLTNBoard
import ChemistryShared

class MasterAtomsViewController: UITableViewController, UISearchResultsUpdating, PackDelegate {
    func packObserve(didGetPack pack: ChemistryPack) {
        
    }
    
    func packObserve(didListPack pack: Dictionary<String, ChemistryPack>) {
        
    }
    
    
    var detailViewController: DetailViewController? = nil
    
    var packSource: PackSource?
    var objects_keys: [String] = []
    var objects: [String : ChemistryAtom] = [:]
    
    var searchController = UISearchController()
    var filteredAtoms: [String : ChemistryAtom] = [:]
    
    lazy var descriptor: BLTNItemManager = {
        let page = BLTNPageItem(title: LocalizedStringSpecific("AtomsDescriptorTitle"))
        
        page.descriptionText = LocalizedStringSpecific("AtomsDescriptorText")
        page.actionButtonTitle = LocalizedStringSpecific("AtomsDescriptorButton")
        page.appearance.actionButtonColor = self.view.tintColor
        page.requiresCloseButton = false
        
        page.actionHandler = { (item: BLTNActionItem) in
            item.manager!.dismissBulletin(animated: true)
            self.userDefaults?.set(true, forKey: "atoms_descripted")
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
            detailViewController = (controllers[controllers.count-1] as? UINavigationController)?.topViewController as? DetailViewController
        }
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        
        tableView.reloadData()
        
        if !(userDefaults?.bool(forKey: "molecules_descripted"))! {
            descriptor.showBulletin(above: UIApplication.shared.keyWindow!.rootViewController!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    @objc
    func insertAtoms(_ sender: Any) {
        packSource = MyPackSource(delegate: self)
        
        var packs = packSource?.listPack()
        let base = getBasePack()
        packs?["Base"] = base
        
        packs?.forEach({ (arg0) in
            let (_, value) = arg0
            value.atoms.forEach({ (molecule: ChemistryAtom) in
                objects_keys.append(molecule.title.base!)
                objects[molecule.title.base!] = molecule
            })
        })
        
        objects_keys = objects_keys.sorted { (s0, s1) -> Bool in
            return objects[s0]!.number < objects[s1]!.number
        }
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let indexPath = tableView.indexPathForSelectedRow {
            let object: ChemistryAtom
            if searchController.isActive {
                object = filteredAtoms[Array(filteredAtoms.keys)[indexPath.row]]!
            } else {
                object = objects[objects_keys[indexPath.row]]!
            }
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailAtom = object
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
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
        let object: ChemistryAtom
        if searchController.isActive {
            object = filteredAtoms[Array(filteredAtoms.keys)[indexPath.row]]!
        } else {
            object = objects[Array(objects_keys)[indexPath.row]]!
        }
        cell.textLabel!.text = object.symbol
        cell.detailTextLabel!.text = NSLocalizedString(object.title.base!, comment: "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredAtoms.removeAll(keepingCapacity: false)
        
        let array = objects.filter({atom -> Bool in
            let a1 = atom.value.title.base!.lowercased()
            let a2 = searchController.searchBar.text!.lowercased()
            return a1.contains(a2)
        }) // Symbols
        let array2 = objects.filter({atom -> Bool in
            let a1 = atom.value.symbol.lowercased()
            let a2 = searchController.searchBar.text!.lowercased()
            return a1.contains(a2)
        }) // Names
        
        filteredAtoms += array
        filteredAtoms += array2
        
        self.tableView.reloadData()
    }
}

func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}
