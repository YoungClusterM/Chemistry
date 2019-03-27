//
//  H2.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import Foundation
import SceneKit

class H2 : Molecule {
    override func draw() -> SCNNode {
        let atom1 = Atoms["H"]!.draw()
        let atom2 = Atoms["H"]!.draw()
        
        let atom1Node = atom1.ToNode()
        let atom2Node = atom2.ToNode()
        
        atom1Node.position.x = Float(atom2.radius)/2
        atom2Node.position.x = -(Float(atom1.radius))/2
        
        let moleculeNode = SCNNode()
        moleculeNode.addChildNode(atom1Node)
        moleculeNode.addChildNode(atom2Node)
        
        return moleculeNode
    }
}
