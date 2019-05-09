//
//  PackDelegate.swift
//  ChemistryShared
//
//  Created by Pavel Kasila on 5/9/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation

protocol PackDelegate {
    func pack(shouldGetPack pack: ChemistryPack) -> ChemistryPack
    func pack(didGetPack pack: ChemistryPack)
    
    func pack(shouldListPack pack: [ChemistryPack]) -> [ChemistryPack]
    func pack(didListPack pack: [ChemistryPack])
}
