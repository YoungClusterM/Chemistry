//
//  MoleculesSplitViewController.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/19/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import AppKit

class MoleculesSplitViewController: NSSplitViewController {
    var detailViewController: DetailViewController?
    var masterViewController: CollectionMoleculesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewController = splitViewItems[1].viewController as? DetailViewController
        masterViewController = splitViewItems[0].viewController as? CollectionMoleculesViewController
        
        masterViewController?.detailDelegate = detailViewController
    }
}
