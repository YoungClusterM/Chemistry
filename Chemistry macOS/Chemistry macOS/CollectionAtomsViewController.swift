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
        guard let collectionViewItem = item as? CollectionViewItem else {
            let text =  "Cannot convert NSCollectionViewItem to CollectionViewItem\n" +
                "Seems like dataset is corrupted. Please download original or tested dataset (likes below)\n" +
                "Latest: https://eduservice.oopscommand.com/chemistry/downloads/macOS/datasets/latest.json\n" +
                "Tested: https://eduservice.oopscommand.com/chemistry/downloads/macOS/datasets/tested.json\n" +
            "MOVE IT TO: \(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0])/EduService/Chemistry/dataset.json"
            let alert = NSAlert.init()
            alert.messageText = "Error"
            alert.informativeText = text
            alert.alertStyle = .critical
            alert.addButton(withTitle: "OK")
            alert.runModal()
            fatalError(text)
        }
        
        collectionViewItem.atom = objects[indexPath.item]
        
        return collectionViewItem
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        collectionView.register(CollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"))
        collectionView.reloadData()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        collectionView.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: (collectionView.collectionViewLayout?.collectionViewContentSize.height)!)
    }
}
