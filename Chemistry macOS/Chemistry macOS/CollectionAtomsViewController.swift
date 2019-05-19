//
//  CollectionAtomsViewController.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/7/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Cocoa
import ChemistryShared

class CollectionAtomsViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, PackDelegate, DetailSource {
    var detailDelegate: DetailDelegate?
    
    func packObserve(didGetPack pack: ChemistryPack) {
        
    }
    
    func packObserve(didListPack pack: Dictionary<String, ChemistryPack>) {
        
    }
    
    
    var packSource: PackSource?

    @IBOutlet weak var collectionView: CollectionAtomsView!
    var objects_keys: [String] = []
    var objects: [String : ChemistryAtom] = [:]
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {
            return CollectionViewItem()
        }
        
        collectionViewItem.atom = objects[objects_keys[indexPath.item]]
        
        return collectionViewItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt
        indexPaths: Set<IndexPath>) {
        for index in indexPaths {
            let key = objects_keys[index.item] as String
            didSelectedItem(symbol: key, atom: objects[key]!)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
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
        
        collectionView.register(CollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"))
        collectionView.reloadData()
    }
    
    override func viewDidAppear() {
        collectionView.reloadData()
        setupViewRect()
    }
    
    func setupViewRect() {
        collectionView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: (collectionView.collectionViewLayout?.collectionViewContentSize.height)!)
    }
    
    var selectedItem: CollectionViewItem?
    
    func didSelectedItem(symbol: String, atom: ChemistryAtom) {
        detailDelegate?.show(atom: atom)
    }
}

class CollectionAtomsView: NSCollectionView {
}
