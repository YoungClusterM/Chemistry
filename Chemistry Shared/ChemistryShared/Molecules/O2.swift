//
//  O2.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import Foundation
import SceneKit

class O2 : Molecule {
    override func draw() -> SCNNode {
        let atom1 = Atoms["O"]!.draw()
        let atom2 = Atoms["O"]!.draw()
        
        let atom1Node = atom1.ToNode()
        let atom2Node = atom2.ToNode()
        
        #if os(iOS) || os(watchOS) || os(tvOS)
        atom1Node.position.x = Float(atom2.radius)/2
        atom2Node.position.x = -(Float(atom1.radius))/2
        #elseif os(OSX)
        atom1Node.position.x = atom2.radius/2
        atom2Node.position.x = -(atom1.radius)/2
        #endif
        
        let moleculeNode = SCNNode()
        moleculeNode.addChildNode(atom1Node)
        moleculeNode.addChildNode(atom2Node)
        
        return moleculeNode
    }
}
