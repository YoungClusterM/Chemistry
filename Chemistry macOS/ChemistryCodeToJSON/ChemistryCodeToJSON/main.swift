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

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}

let settings = ChemistryPackDetails(
    title: CommandLine.argc > 2 ? CommandLine.arguments[2] : randomString(length: 16),
    version: CommandLine.argc > 3 ? CommandLine.arguments[3] : "0.0.0",
    type: CommandLine.argc != 1 ? CommandLine.arguments[1] : "atoms",
    copyright: "© 2019 " + (CommandLine.argc > 4 ? CommandLine.arguments[4] : NSFullUserName()) + ". All rights reserved."
)

var items: [ChemistryAtom] = []

switch(settings.type) {
case "atoms":
    items = packAtoms(Atoms)
default:
    fatalError("Cannot use type called \"\(settings.type)\"")
}

let pack = ChemistryPack(
    packDetails: settings,
    items: items
)

let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
let jsonData = try jsonEncoder.encode(pack)

print(String(decoding: jsonData, as: UTF8.self))