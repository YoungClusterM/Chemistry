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

class CollectionMoleculesViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, PackDelegate {
    
    var packSource: PackSource?
    
    func pack(didGetPack pack: ChemistryPack) {
        
    }
    
    func pack(didListPack pack: Dictionary<String, ChemistryPack>) {
        
    }
    
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var objects = Array<String>()
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {
            return CollectionViewItem()
        }
        
        collectionViewItem.atom = objects[indexPath.item]
        
        return collectionViewItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt
        indexPaths: Set<IndexPath>) {
        for index in indexPaths {
            let key = objects[index.item] as String
            didSelectedItem(symbol: key, atom: Atoms[key]!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        packSource = MyPackSource(delegate: self)
        
        let packs = packSource?.listPack()
        var molecules: Dictionary<String, ChemistryMolecule> = []
        
        packs?.forEach({ ((key: String, value: ChemistryPack)) in
            molecules
        })
        
        objects.append(contentsOf: )
        
        collectionView.register(CollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"))
        collectionView.reloadData()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        collectionView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: (collectionView.collectionViewLayout?.collectionViewContentSize.height)!)
    }
    
    var selectedItem: CollectionViewItem?
    
    func didSelectedItem(symbol: String, atom: Atom) {
        let text =
            "Symbol: \(symbol)\n" +
                "Title: \(atom.wikipedia)\n" +
                "Number: \(atom.num)\n" +
                "Mass: \(atom.atomMass)\n" +
        "Radius: \(atom.pm) pm\n"
        let alert = NSAlert.init()
        alert.messageText = "Atom"
        alert.informativeText = text
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    let moleculesLoader = MoleculesLoadWindow()
    @IBAction func addMolecules(_ sender: Any) {
        moleculesLoader.loadWindow()
        moleculesLoader.showWindow(nil)
    }
}

class CollectionMoleculesView: NSCollectionView {
}
