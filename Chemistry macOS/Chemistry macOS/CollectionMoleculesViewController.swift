//
//  CollectionMoleculesViewController.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/9/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import AppKit
import ChemistryShared

class CollectionMoleculesViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, PackDelegate, DetailSource {
    func packObserve(didGetPack pack: ChemistryPack) {
        
    }
    
    func packObserve(didListPack pack: Dictionary<String, ChemistryPack>) {
        
    }
    
    
    var packSource: PackSource?
    
    var detailDelegate: DetailDelegate?
    
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var objects: [String : ChemistryMolecule] = [:]
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionMoleculeItem"), for: indexPath)
        guard let collectionViewItem = item as? CollectionMoleculeItem else {
            return CollectionMoleculeItem()
        }
        
        collectionViewItem.molecule = objects[Array(objects.keys)[indexPath.item]]
        
        return collectionViewItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt
        indexPaths: Set<IndexPath>) {
        for index in indexPaths {
            let key = Array(objects.keys)[index.item] as String
            didSelectedItem(symbol: key, molecule: objects[key]!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        packSource = MyPackSource(delegate: self)
        
        var packs = packSource?.listPack()
        let base = getBasePack(network: false)
        packs?["Base"] = base
        
        packs?.forEach({ (arg0) in
            let (_, value) = arg0
            value.molecules.forEach({ (molecule: ChemistryMolecule) in
                objects[molecule.title] = molecule
            })
        })
        
        collectionView.register(CollectionMoleculeItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionMoleculeItem"))
        collectionView.reloadData()
        setupViewRect()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupViewRect()
    }
    
    override func viewDidAppear() {
        collectionView.reloadData()
        setupViewRect()
    }
    
    func setupViewRect() {
        collectionView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: (collectionView.collectionViewLayout?.collectionViewContentSize.height)!)
    }
    
    var selectedItem: CollectionViewItem?
    
    func didSelectedItem(symbol: String, molecule: ChemistryMolecule) {
        detailDelegate?.show(molecule: molecule)
    }
    
    let moleculesLoader = MoleculesLoadWindow()
    @IBAction func addMolecules(_ sender: Any) {
        moleculesLoader.loadWindow()
        moleculesLoader.showWindow(nil)
    }
}

class CollectionMoleculesView: NSCollectionView {
}
