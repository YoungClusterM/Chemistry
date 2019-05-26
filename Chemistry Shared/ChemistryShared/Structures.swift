//
//  Structures.swift
//  ChemistryCodeToJSON
//
//  Created by Pavel Kasila on 5/8/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import CoreGraphics
import SceneKit

// Our .pack file manifest structure
public struct ChemistryPack: Encodable, Decodable {
    public var packDetails: ChemistryPackDetails
    public var atoms: [ChemistryAtom] = []
    public var molecules: [ChemistryMolecule] = []
    public init(packDetails: ChemistryPackDetails, items: [ChemistryAtom]) {
        self.packDetails = packDetails
        self.atoms = items
    }
    public init(packDetails: ChemistryPackDetails, items: [ChemistryMolecule]) {
        self.packDetails = packDetails
        self.molecules = items
    }
    public init(packDetails: ChemistryPackDetails, atoms: [ChemistryAtom], molecules: [ChemistryMolecule]) {
        self.packDetails = packDetails
        self.atoms = atoms
        self.molecules = molecules
    }
}

// Pack's details structure
public struct ChemistryPackDetails: Encodable, Decodable {
    public var title: String
    public var version: String
    public var type: String
    public var copyright: String
    
    public init(title: String, version: String, type: String, copyright: String) {
        self.title = title
        self.version = version
        self.type = type
        self.copyright = copyright
    }
}

// Atom's structure
public struct ChemistryAtom: Encodable, Decodable {
    public var symbol: String
    public var number: Int
    public var title: ChemistryAtomTitle
    public var color: ChemistryColor
    public var radius: Int
    public var mass: Float
    public init(symbol: String, number: Int, title: ChemistryAtomTitle, color: ChemistryColor, radius: Int, mass: Float) {
        self.symbol = symbol
        self.number = number
        self.title = title
        self.color = color
        self.radius = radius
        self.mass = mass
    }
}

public struct ChemistryAtomTitle: Encodable, Decodable {
    public var base: String? // Base
    public var en: String?   // English
    public var ru: String?   // Russian
    public var be: String?   // Belarusian
}

// Molecules's struct
public struct ChemistryMolecule: Encodable, Decodable {
    public var title: String
    public var atoms: [ChemistryMoleculeAtom]
    public init(title: String, atoms: [ChemistryMoleculeAtom]) {
        self.title = title
        self.atoms = atoms
    }
}

public func drawChemistryMolecule(_ molecule: ChemistryMolecule) -> SCNNode {
    let mainNode = SCNNode()
    
    molecule.atoms.forEach { (atom: ChemistryMoleculeAtom) in
        let atom1 = Atoms[atom.symbol]?.draw().ToNode()
        #if os(iOS) || os(watchOS) || os(tvOS)
        atom1?.position.x = Float(atom.position[0])
        atom1?.position.y = Float(atom.position[1])
        atom1?.position.z = Float(atom.position[2])
        #elseif os(OSX)
        atom1?.position.x = CGFloat(atom.position[0])
        atom1?.position.y = CGFloat(atom.position[1])
        atom1?.position.z = CGFloat(atom.position[2])
        #endif
        mainNode.addChildNode(atom1!)
    }
    
    return mainNode
}

public struct ChemistryMoleculeAtom: Encodable, Decodable {
    public var symbol: String
    public var position: [Float]
    public init(symbol: String, position: [Float]) {
        self.symbol = symbol
        self.position = position
    }
}

// Color's structure
public struct ChemistryColor: Encodable, Decodable {
    public var red: CGFloat
    public var green: CGFloat
    public var blue: CGFloat
    public init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
