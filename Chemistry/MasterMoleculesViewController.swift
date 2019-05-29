//
//  MasterMoleculesViewController.swift
//  Chemistry
//
//  Created by Паша Косило on 3/17/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import UIKit
import BLTNBoard
import ChemistryShared

class MasterMoleculesViewController: UITableViewController, UISearchResultsUpdating, PackDelegate {
    
    func packObserve(didGetPack pack: ChemistryPack) {
        
    }
    
    func packObserve(didListPack pack: [String : ChemistryPack]) {
        
    }
    
    
    var detailViewController: DetailViewController?
    
    var objects: [String : ChemistryMolecule] = [:]
    var packSource: PackSource?
    
    var searchController = UISearchController()
    var filteredMolecules: [String] = []
    
    lazy var descriptor: BLTNItemManager = {
        let page = BLTNPageItem(title: LocalizedStringSpecific("MoleculesDescriptorTitle"))
        
        page.image = UIImage(named: "molecule_descriptor")
        page.descriptionText = LocalizedStringSpecific("MoleculesDescriptorText")
        page.actionButtonTitle = LocalizedStringSpecific("MoleculesDescriptorButton")
        page.appearance.actionButtonColor = self.view.tintColor
        page.requiresCloseButton = false
        
        page.actionHandler = { (item: BLTNActionItem) in
            item.manager!.dismissBulletin(animated: true)
            self.userDefaults?.set(true, forKey: "molecules_descripted")
            }
        
        return BLTNItemManager(rootItem: page)
    }()
    
    let userDefaults = UserDefaults(suiteName: "Chemistry")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        packSource = PackSource(delegate: self)
        
        insertMolecules(self)
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
    func insertMolecules(_ sender: Any) {
        var packs = packSource?.listPack()
        packs?["Base"] = getBasePack(network: false)
        
        packs?.forEach({ (arg0) in
            let (_, value) = arg0
            value.molecules.forEach({ (molecule: ChemistryMolecule) in
                objects[molecule.title] = molecule
            })
        })
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let indexPath = tableView.indexPathForSelectedRow {
            let object: ChemistryMolecule
            if searchController.isActive {
                object = objects[filteredMolecules[indexPath.row]]!
            } else {
                object = objects[Array(objects.keys)[indexPath.row]]!
            }
            let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailViewController
            controller?.detailMolecule = object
            controller?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller?.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredMolecules.count
        }
        
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object: String
        if searchController.isActive {
            object = filteredMolecules[indexPath.row]
        } else {
            object = Array(objects.keys)[indexPath.row]
        }
        cell.textLabel!.text = object.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredMolecules.removeAll(keepingCapacity: false)
        
        let array = (Array(objects.keys) as Array).filter({atom -> Bool in
            let a1 = atom.numbersInsteadChemistry().lowercased()
            let a2 = searchController.searchBar.text!.numbersInsteadChemistry().lowercased()
            return a1.contains(a2)
        })
        filteredMolecules = array
        
        self.tableView.reloadData()
    }
    
    
}

extension String {
    func numbersInsteadChemistry() -> String {
        return self.replacingOccurrences(of: "₀", with: "0").replacingOccurrences(of: "₁", with: "1").replacingOccurrences(of: "₂", with: "2").replacingOccurrences(of: "₃", with: "3").replacingOccurrences(of: "₄", with: "4").replacingOccurrences(of: "₅", with: "5").replacingOccurrences(of: "₆", with: "6").replacingOccurrences(of: "₇", with: "7").replacingOccurrences(of: "₈", with: "8").replacingOccurrences(of: "₉", with: "9")
    }
}
