//
//  AppDelegate.swift
//  Chemistry macOS
//
//  Created by Pavel Kasila on 5/6/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let moleculesLoader = MoleculesLoadWindow()
    @IBAction func addMoleculesLocal(_ sender: Any) {
        moleculesLoader.loadWindow()
        moleculesLoader.showWindow(nil)
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

