//
//  H2O.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import Foundation
import SceneKit

class H2O : Molecule {
    override func draw() -> SCNNode {
        let atom1 = Atoms["H"]!.draw()
        let atom2 = Atoms["H"]!.draw()
        let atom3 = Atoms["O"]!.draw()
        
        let atom1Node = atom1.ToNode()
        atom1Node.name = "H"
        let atom2Node = atom2.ToNode()
        atom2Node.name = "H"
        let atom3Node = atom3.ToNode()
        atom3Node.name = "O"
        
        #if os(iOS) || os(watchOS) || os(tvOS)
        atom1Node.position.x = Float(atom3.radius)
        atom2Node.position.x = -(Float(atom3.radius))
        #elseif os(OSX)
        atom1Node.position.x = atom3.radius
        atom2Node.position.x = -(atom3.radius)
        #endif
        
        let moleculeNode = SCNNode()
        moleculeNode.addChildNode(atom1Node)
        moleculeNode.addChildNode(atom2Node)
        moleculeNode.addChildNode(atom3Node)
        
        moleculeNode.name = "H₂O"
        
        return moleculeNode
    }
}
