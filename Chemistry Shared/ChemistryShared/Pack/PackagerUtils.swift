//
//  PackagerUtils.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/12/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import SceneKit

public func pack(atoms: Dictionary<String, Atom>) -> [ChemistryAtom] {
    var items: [ChemistryAtom] = []
    
    atoms.forEach { (arg) in
        let (key, value) = arg
        #if os(iOS) || os(watchOS) || os(tvOS)
        let color: UIColor? = value.color
        let color_red = color!.ciColor.red
        let color_green = color!.ciColor.green
        let color_blue = color!.ciColor.blue
        #elseif os(OSX)
        let color = value.color.usingColorSpace(.adobeRGB1998)
        let color_red = color!.redComponent
        let color_green = color!.greenComponent
        let color_blue = color!.blueComponent
        #endif
        
        var atomTitle = ChemistryAtomTitle()
        atomTitle.base = value.wikipedia
       
        items.append(
            ChemistryAtom(
                symbol: key,
                number: Int(value.num),
                title: atomTitle,
                color: ChemistryColor(
                    red: color_red,
                    green: color_green,
                    blue: color_blue
                ),
                radius: Int(value.pm),
                mass: value.atomMass
            )
        )
    }
    
    return items
}

public func pack(molecules: [String : SCNNode]) -> [ChemistryMolecule] {
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

public func getBasePack(network: Bool) -> ChemistryPack {
    var sourceURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
    sourceURL.appendPathComponent("base.json")
    if network {
        do {
            let data = try Data(contentsOf: URL(string: EduServiceInformation().getInformation().manifest)!, options: .alwaysMapped)
            let pack = try JSONDecoder().decode(ChemistryPack.self, from: data)
            
            do {
                try data.write(to: sourceURL, options: .atomic)
            } catch {
                print("Cannot save base manifest for future use")
            }
            
            return pack
        } catch _ as NSError {
            return ChemistryPack(packDetails: ChemistryPackDetails(title: "Nothing", version: "NONE", type: "chemistry", copyright: "NONE"), atoms: [], molecules: [])
        }
    } else {
        do {
            let data = try Data(contentsOf: sourceURL, options: .alwaysMapped)
            let pack = try JSONDecoder().decode(ChemistryPack.self, from: data)
            return pack
        } catch _ as NSError {
            return getBasePack(network: true)
        }
    }
}
