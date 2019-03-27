//
//  F2.swift
//  Chemistry
//
//  Created by Паша Косило on 3/16/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import Foundation
import SceneKit

class F2 : Molecule {
    override func draw() -> SCNNode {
        let atom1 = Atoms["F"]!.draw()
        let atom2 = Atoms["F"]!.draw()
        
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
