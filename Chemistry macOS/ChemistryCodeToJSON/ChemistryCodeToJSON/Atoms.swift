//
//  Atoms.swift
//  ChemistryCodeToJSON
//
//  Created by Pavel Kasila on 5/8/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import ChemistryShared

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
