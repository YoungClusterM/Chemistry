//
//  Fe2O3.swift
//  Chemistry
//
//  Created by Паша Косило on 3/18/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import Foundation
import SceneKit

class Fe2O3 : Molecule {
    override func draw() -> SCNNode {
        let atom1 = Atoms["Fe"]!.draw()
        let atom2 = Atoms["Fe"]!.draw()
        
        let atomO1 = Atoms["O"]!.draw()
        let atomO2 = Atoms["O"]!.draw()
        let atomO3 = Atoms["O"]!.draw()
        
        let atom1Node = atom1.ToNode()
        let atom2Node = atom2.ToNode()
        
        let atomO1Node = atomO1.ToNode()
        let atomO2Node = atomO2.ToNode()
        let atomO3Node = atomO3.ToNode()
        
        // Fe
        atom1Node.position.x = Float(atom2.radius)/2
        atom2Node.position.x = -(Float(atom1.radius))/2
        
        // O
        atomO1Node.position.x = atom1Node.position.x*2
        atomO2Node.position.x = atom2Node.position.x*2
        atomO1Node.position.y = -Float(atom1.radius)
        atomO2Node.position.y = -Float(atom2.radius)
        atomO3Node.position.y = Float(atom1.radius)
        
        let moleculeNode = SCNNode()
        moleculeNode.addChildNode(atom1Node)
        moleculeNode.addChildNode(atom2Node)
        
        moleculeNode.addChildNode(atomO1Node)
        moleculeNode.addChildNode(atomO2Node)
        moleculeNode.addChildNode(atomO3Node)
        
        return moleculeNode
    }
}
