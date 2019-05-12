//
//  CollectionMoleculeItem.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/12/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Cocoa
import SceneKit
import ChemistryShared

class CollectionMoleculeItem: NSCollectionViewItem {

    var molecule: ChemistryMolecule? {
        didSet {
            nameLabel.stringValue = molecule!.title
            var molMass: Float = 0
            
            molecule?.atoms.forEach({ (atom: ChemistryMoleculeAtom) in
                let atom1 = Atoms[atom.symbol]!
                molMass += atom1.atomMass
            })
            
            massLabel.stringValue = "\(molMass)"
        }
    }
    
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var massLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.cornerRadius = 5.0
    }
    
    override var highlightState: NSCollectionViewItem.HighlightState {
        didSet {
            switch(self.highlightState) {
            case .none:
                view.layer?.borderWidth = 0.0
                view.layer?.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
            case .forSelection:
                view.layer?.borderWidth = 2.0
                view.layer?.borderColor = NSColor.controlAccentColor.cgColor
            case .forDeselection:
                view.layer?.borderWidth = 0.0
                view.layer?.borderColor = NSColor.controlAccentColor.cgColor
            case .asDropTarget:
                view.layer?.borderWidth = 2.0
                view.layer?.borderColor = NSColor.controlAccentColor.cgColor
            @unknown default:
                view.layer?.borderWidth = 0.0
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setColor(NSColor.controlAccentColor.cgColor)
            } else {
                setColor(.clear)
            }
        }
    }
    
    func setColor(_ color: CGColor) {
        view.layer?.backgroundColor = isSelected ? color.copy(alpha: 0.2) : color
        nameLabel.textColor = isSelected ? nameLabel.textColor?.withAlphaComponent(1) : NSColor.labelColor
        massLabel.textColor = isSelected ? massLabel.textColor?.withAlphaComponent(1) : NSColor.labelColor
    }
    
}
