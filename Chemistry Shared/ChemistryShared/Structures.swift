//
//  Structures.swift
//  ChemistryCodeToJSON
//
//  Created by Pavel Kasila on 5/8/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import CoreGraphics

public struct ChemistryPack: Encodable, Decodable {
    public var packDetails: ChemistryPackDetails
    public var items: [ChemistryAtom]
    public init(packDetails: ChemistryPackDetails, items: [ChemistryAtom]) {
        self.packDetails = packDetails
        self.items = items
    }
}

public struct ChemistryPackDetails: Encodable, Decodable {
    public var title: String
    public var version: String
    public var type: String
    public var copyright: String
    
    public init(title: String, version: String, type: String, copyright: String) {
        self.title = title
        self.version = version
        self.type = type
        self.copyright = copyright
    }
}

public struct ChemistryAtom: Encodable, Decodable {
    public var symbol: String
    public var number: Int
    public var title: String
    public var color: ChemistryColor
    public var radius: Int
    public var mass: Float
    public init(symbol: String, number: Int, title: String, color: ChemistryColor, radius: Int, mass: Float) {
        self.symbol = symbol
        self.number = number
        self.title = title
        self.color = color
        self.radius = radius
        self.mass = mass
    }
}

public struct ChemistryColor: Encodable, Decodable {
    public var red: CGFloat
    public var green: CGFloat
    public var blue: CGFloat
    public init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
