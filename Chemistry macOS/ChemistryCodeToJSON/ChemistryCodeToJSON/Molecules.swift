//
//  Molecules.swift
//  ChemistryCodeToJSON
//
//  Created by Pavel Kasila on 5/12/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import SceneKit
import ChemistryShared

func pack(molecules: [String : SCNNode]) -> [ChemistryMolecule] {
    var items: [ChemistryMolecule] = []
    
    molecules.forEach { (arg) in
        let (key, value) = arg
        let molecule = value
        var export: Array<ChemistryMoleculeAtom> = []
        molecule.childNodes.forEach({ (node: SCNNode) in
            let position = [
                Float(node.position.x),
                Float(node.position.y),
                Float(node.position.z)
            ]
            let title = node.name!
            export.append(ChemistryMoleculeAtom(
                symbol: title, position: position
            ))
        })
        items.append(ChemistryMolecule(
            title: key,
            atoms: export
        ))
    }
    
    return items
}
