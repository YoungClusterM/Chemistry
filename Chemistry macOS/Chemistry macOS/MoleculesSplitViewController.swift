//
//  MoleculesSplitViewController.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/19/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import AppKit

class SplitViewController: NSSplitViewController {
    var detailViewController: DetailViewController?
    var masterViewController: DetailSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewController = splitViewItems[1].viewController as? DetailViewController
        masterViewController = splitViewItems[0].viewController as? DetailSource
        
        masterViewController?.detailDelegate = detailViewController
    }
}

protocol DetailSource {
    var detailDelegate: DetailDelegate? { get set }
}
