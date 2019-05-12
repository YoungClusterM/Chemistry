//
//  PackagerUtils.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/12/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import ChemistryShared
import SceneKit

func pack(atoms: Dictionary<String, Atom>) -> [ChemistryAtom] {
    var items: [ChemistryAtom] = []
    
    atoms.forEach { (arg) in
        let (key, value) = arg
        let color = value.color.usingColorSpace(.adobeRGB1998)
        items.append(
            ChemistryAtom(
                symbol: key,
                number: Int(value.num),
                title: value.wikipedia,
                color: ChemistryColor(
                    red: color!.redComponent,
                    green: color!.greenComponent,
                    blue: color!.blueComponent
                ),
                radius: Int(value.pm),
                mass: value.atomMass
            )
        )
    }
    
    return items
}

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
