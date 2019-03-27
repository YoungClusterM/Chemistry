//
//  Molecules.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import Foundation
import SceneKit

class Molecule {
    func draw() -> SCNNode {
        return SCNNode()
    }
}

let Molecules: [String:SCNNode] = [
    "H₂O": H2O().draw(),
    "H₂": H2().draw(),
    "O₂": O2().draw(),
    "F₂": F2().draw(),
    "F₂O₃": Fe2O3().draw(),
]
