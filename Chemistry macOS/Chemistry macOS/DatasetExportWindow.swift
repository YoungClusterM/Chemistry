//
//  DatasetExportWindow.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/12/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Cocoa
import ChemistryShared

class DatasetExportWindow: NSWindowController {

    convenience init() {
        self.init(windowNibName: "DatasetExportWindow")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}

class DatasetExportWin: NSWindow {
    @IBOutlet weak var titleField: NSTextField!
    @IBOutlet weak var versionField: NSTextField!
    @IBOutlet weak var authorField: NSTextField!
    
    @IBAction func exportDataset(_ sender: Any) {
        let savePanel = NSSavePanel()
        savePanel.nameFieldStringValue = "manifest"
        savePanel.allowedFileTypes = ["json"]
        let result = savePanel.runModal()
        if(result.rawValue == NSApplication.ModalResponse.OK.rawValue) {
            let url = savePanel.url!
            
            let settings = ChemistryPackDetails(
                title: titleField.stringValue,
                version: versionField.stringValue,
                type: "chemistry",
                copyright: "© 2019 " + authorField.stringValue + ". All rights reserved."
            )
            
            let atoms = pack(atoms: Atoms)
            let molecules = pack(molecules: Molecules)
            
            let pack = ChemistryPack(
                packDetails: settings,
                atoms: atoms,
                molecules: molecules
            )
            
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(pack)
                try jsonData.write(to: url)
            } catch let error as NSError {
                fatalError("Error: \(error)")
            }
            self.close()
        }
    }
}
