//
//  MyPackSource.swift
//  Chemistry-iOS
//
//  Created by Pavel Kasila on 5/13/19.
//  Copyright © 2019 Pavel Kosilo. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import ChemistryShared

class MyPackSource : PackSource {
    
    let fileManager = FileManager.default
    
    var delegate: PackDelegate?
    
    init() {
        loadAtoms()
    }
    
    init(delegate: PackDelegate) {
        self.delegate = delegate
        loadAtoms()
    }
    
    private func loadAtoms() {
        var packs = self.listPack()
        let base = getBasePack()
        packs["Base"] = base
        
        packs.forEach({ (arg0) in
            let (_, value) = arg0
            value.atoms.forEach({ (atom: ChemistryAtom) in
                Atoms[atom.symbol] = Atom(
                    pm: Float(atom.radius),
                    color: UIColor(red: atom.color.red, green: atom.color.green, blue: atom.color.blue, alpha: 1),
                    num: Int8(atom.number),
                    wikipedia: atom.title.base!,
                    atomMass: atom.mass
                )
            })
        })
    }
    
    func getPack(_ id: String) -> ChemistryPack {
        let packs = listPack()
        
        guard let pack = packs[id] else { fatalError("Unknown id (\(id)) for getPack") }
        
        delegate?.packObserve(didGetPack: pack)
        
        return pack
    }
    
    func listPack() -> Dictionary<String, ChemistryPack> {
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

