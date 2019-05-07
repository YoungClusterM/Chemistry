//
//  String.swift
//  Chemistry
//
//  Created by Pavel Kasila on 4/23/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import Foundation

public func LocalizedStringSpecific(_ key: String, equalsKey: Bool = true) -> String {
    let value = NSLocalizedString(key, comment: "")
    
    let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
    let bundle = Bundle(path: path!)
    let baseString = NSLocalizedString(key, bundle: bundle!, comment: "")
    if !(value == baseString || (key == value)) {
        return value
    } else {
        return baseString
    }
}

public func LocalizedHost(_ key: String, equalsKey: Bool = true) -> String {
    let value = NSLocalizedString(key, comment: "")
    
    let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
    let bundle = Bundle(path: path!)
    let baseString = NSLocalizedString(key, bundle: bundle!, comment: "")
    if !(value == baseString || (!equalsKey && key == value)) {
        return value
    } else {
        return baseString
    }
}
