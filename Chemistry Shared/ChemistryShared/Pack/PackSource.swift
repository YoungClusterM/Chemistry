//
//  PackSource.swift
//  ChemistryShared
//
//  Created by Pavel Kasila on 5/9/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation

public protocol PackSource {
    var delegate: PackDelegate? { get set }
    
    func getPack(_ id: String) -> ChemistryPack
    func listPack() -> Dictionary<String, ChemistryPack>
}
