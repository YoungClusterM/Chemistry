//
//  CollectionViewItem.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/7/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Cocoa
import SceneKit
import ChemistryShared

class CollectionViewItem: NSCollectionViewItem {
    
    var atom: String? {
        didSet {
            atomTitle.stringValue = Atoms[atom!]!.wikipedia
            atomLabel.stringValue = atom!
            atomNumber.stringValue = String(Atoms[atom!]!.num)
            atomMass.stringValue = Atoms[atom!]!.atomMass != -1 ? String(Atoms[atom!]!.atomMass) : "Unknown"
        }
    }
    
    @IBOutlet weak var atomLabel: NSTextField!
    @IBOutlet weak var atomTitle: NSTextField!
    @IBOutlet weak var atomNumber: NSTextField!
    @IBOutlet weak var atomMass: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                let view = collectionView as! CollectionAtomsView
                view.didSelectedItem(item: self)
            }
        }
    }
    
}
