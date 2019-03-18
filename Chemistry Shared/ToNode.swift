//
//  ToNode.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import Foundation
import SceneKit

extension SCNGeometry {
    func ToNode() -> SCNNode {
        return SCNNode(geometry: self)
    }
}
