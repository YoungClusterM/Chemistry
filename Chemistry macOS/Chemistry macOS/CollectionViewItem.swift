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
        atomTitle.textColor = isSelected ? atomTitle.textColor?.withAlphaComponent(1) : NSColor.labelColor
        atomLabel.textColor = isSelected ? atomLabel.textColor?.withAlphaComponent(1) : NSColor.labelColor
        atomNumber.textColor = isSelected ? atomNumber.textColor?.withAlphaComponent(1) : NSColor.labelColor
        atomMass.textColor = isSelected ? atomMass.textColor?.withAlphaComponent(1) : NSColor.labelColor
    }
    
}
