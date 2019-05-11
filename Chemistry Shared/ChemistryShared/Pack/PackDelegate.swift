//
//  PackDelegate.swift
//  ChemistryShared
//
//  Created by Pavel Kasila on 5/9/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation

public protocol PackDelegate {
    func pack(didGetPack pack: ChemistryPack)
    
    func pack(didListPack pack: Dictionary<String, ChemistryPack>)
}
