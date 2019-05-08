//
//  main.swift
//  ChemistryCodeToJSON
//
//  Created by Pavel Kasila on 5/8/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import CoreGraphics
import ChemistryShared
import AppKit

struct ExportablePack: Encodable, Decodable {
    var packDetails: ExportablePackDetails
    var items: [ExportableAtom]
}

struct ExportablePackDetails: Encodable, Decodable {
    var title: String
    var version: String
    var type: String
    var copyright: String
}

struct ExportableAtom: Encodable, Decodable {
    var symbol: String
    var number: Int
    var title: String
    var color: ExportableColor
    var radius: Int
    var mass: Float
}

struct ExportableColor: Encodable, Decodable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
}

var items: [ExportableAtom] = []

Atoms.forEach { (arg) in
    let (key, value) = arg
    let color = value.color.usingColorSpace(.adobeRGB1998)
    items.append(
        ExportableAtom(
            symbol: key,
            number: Int(value.num),
            title: value.wikipedia,
            color: ExportableColor(
                red: color!.redComponent,
                green: color!.greenComponent,
                blue: color!.blueComponent
            ),
            radius: Int(value.pm),
            mass: value.atomMass
        )
    )
}

let pack = ExportablePack(
    packDetails: ExportablePackDetails(
        title: "Atoms",
        version: "1.0.0",
        type: "atoms",
        copyright: "© 2019 Pavel Kasila. All rights reserved."
    ),
    items: items
)

let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
let jsonData = try jsonEncoder.encode(pack)

print(String(decoding: jsonData, as: UTF8.self))
