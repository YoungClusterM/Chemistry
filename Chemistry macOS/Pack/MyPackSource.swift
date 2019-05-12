//
//  MyPackSource.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/11/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Foundation
import ChemistryShared

class MyPackSource : PackSource {
    
    let fileManager = FileManager.default
    
    var delegate: PackDelegate?
    
    init() {
        
    }
    
    init(delegate: PackDelegate) {
        self.delegate = delegate
    }
    
    func getPack(_ id: String) -> ChemistryPack {
        let packs = listPack()
        
        guard let pack = packs[id] else { fatalError("Unknown id (\(id)) for getPack") }
        
        delegate?.pack(didGetPack: pack)
        
        return pack
    }
    
    func listPack() -> Dictionary<String, ChemistryPack> {
        guard let appSupport1 = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { fatalError("Application cannot find Application Support Directory") }
        let appSupport = appSupport1.appendingPathComponent("Chemistry", isDirectory: true)
        
        do {
            try FileManager.default.createDirectory(atPath: appSupport.absoluteString, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
        
        var files: [URL]?
        do {
            files = try fileManager.contentsOfDirectory(at: appSupport, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
        } catch let error as NSError {
            fatalError("cannot read directories from Application Support \(error)")
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
        
        delegate?.pack(didListPack: packsDict)
        return packsDict
    }
    
    
}
