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
    
    var atom: ChemistryAtom? {
        didSet {
            atomTitle.stringValue = atom!.title.base!
            atomLabel.stringValue = atom!.symbol
            atomNumber.stringValue = String(atom!.number)
            atomMass.stringValue = atom!.mass != -1 ? String(atom!.mass) : "Unknown"
        }
    }
    
    @IBOutlet weak var atomLabel: NSTextField!
    @IBOutlet weak var atomTitle: NSTextField!
    @IBOutlet weak var atomNumber: NSTextField!
    @IBOutlet weak var atomMass: NSTextField!
    
    
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
                view.layer?.backgroundColor =  NSColor.controlAccentColor.cgColor.copy(alpha: 0.2)
            } else {
                view.layer?.backgroundColor =  .clear
            }
        }
    }
    
}
