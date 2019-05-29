//
//  PackSource.swift
//  ChemistryShared
//
//  Created by Pavel Kasila on 5/9/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
#else
import Cocoa
#endif

public class PackSource {
    public let fileManager = FileManager.default
    
    public var delegate: PackDelegate?
    
    public init() {
        loadAtoms()
    }
    
    public init(delegate: PackDelegate) {
        self.delegate = delegate
        loadAtoms()
    }
    
    public func loadAtoms() {
        var packs = self.listPack()
        let base = getBasePack(network: false)
        packs["Base"] = base
        
        packs.forEach({ (arg0) in
            let (_, value) = arg0
            value.atoms.forEach({ (atom: ChemistryAtom) in
                #if canImport(UIKit)
                let color = UIColor(red: atom.color.red, green: atom.color.green, blue: atom.color.blue, alpha: 1)
                #else
                let color = NSColor(cgColor: CGColor.init(red: atom.color.red, green: atom.color.green, blue: atom.color.blue, alpha: 1))!
                #endif
                Atoms[atom.symbol] = Atom(
                    pm: Float(atom.radius),
                    color: color,
                    num: Int8(atom.number),
                    wikipedia: atom.title.base!,
                    atomMass: atom.mass
                )
            })
        })
    }
    
    public func getPack(_ id: String) -> ChemistryPack {
        let packs = listPack()
        
        guard let pack = packs[id] else { fatalError("Unknown id (\(id)) for getPack") }
        
        delegate?.packObserve(didGetPack: pack)
        
        return pack
    }
    
    public func listPack() -> Dictionary<String, ChemistryPack> {
        guard let appSupport1 = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return Dictionary<String,ChemistryPack>() }
        let appSupport = appSupport1.appendingPathComponent("Chemistry", isDirectory: true)
        
        do {
            try FileManager.default.createDirectory(atPath: appSupport.absoluteString, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
        
        var files: [URL]?
        do {
            files = try fileManager.contentsOfDirectory(at: appSupport, includingPropertiesForKeys: [.isDirectoryKey], options: .skipsHiddenFiles)
        } catch let error as NSError {
            print(error)
            return Dictionary<String,ChemistryPack>()
        }
        
        var packsDict = Dictionary<String, ChemistryPack>()
        
        files?.forEach({ (url) in
            let id = url.pathComponents.last
            let url = url.appendingPathComponent("manifest.json", isDirectory: false)
            
            do {
                let data = try Data(contentsOf: url)
                let pack = try JSONDecoder().decode(ChemistryPack.self, from: data)
                packsDict.updateValue(pack, forKey: id ?? "none")
            } catch let error as NSError {
                fatalError("cannot read manifest from \(String(describing: id)) pack \(error)")
            }
        })
        
        delegate?.packObserve(didListPack: packsDict)
        return packsDict
    }
}
