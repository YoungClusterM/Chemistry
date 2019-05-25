//
//  AppDelegate.swift
//  Chemistry macOS
//
//  Created by Pavel Kasila on 5/6/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Cocoa
import CoreLocation
import ChemistryShared

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBAction func addMoleculesLocal(_ sender: Any) {
        let moleculesLoader = MoleculesLoadWindow()
        moleculesLoader.loadWindow()
        moleculesLoader.showWindow(nil)
    }
    
    @IBAction func exportDatasetToManifest(_ sender: Any) {
        let exporter = DatasetExportWindow()
        exporter.loadWindow()
        //exporter.showWindow(nil)
        NSApplication.shared.runModal(for: exporter.window!)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed (_ theApplication: NSApplication) -> Bool {
        return true
    }
}

