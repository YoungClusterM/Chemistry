//
//  CollectionAtomsViewController.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/7/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Cocoa
import ChemistryShared

class CollectionAtomsViewController: NSViewController, NSCollectionViewDataSource {

    @IBOutlet weak var collectionView: NSCollectionView!
    let objects = Array(Atoms.keys).sorted { (s1, s2) -> Bool in
        return Atoms[s1]!.num < Atoms[s2]!.num
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {fatalError("Failed to convert item to CollectionViewItem")}
        
        collectionViewItem.atom = objects[indexPath.item]
        
        return collectionViewItem
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        collectionView.register(CollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"))
        collectionView.reloadData()
    }
    
}
