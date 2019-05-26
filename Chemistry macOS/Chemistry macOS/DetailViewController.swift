//
//  DetailViewController.swift
//  Chemistry
//
//  Created by Pavel Kasila on 5/19/19.
//  Copyright © 2019 Pavel Kasila. All rights reserved.
//

import Cocoa
import ChemistryShared
import SceneKit
import WebKit

class DetailViewController: NSViewController, DetailDelegate, WKUIDelegate {
    @IBOutlet var sceneView: SCNView!
    @IBOutlet var atomTitle: NSTextField!
    @IBOutlet var atomDescription: NSTextView!
    @IBOutlet var progressIndicator: NSProgressIndicator!
    
    func show(molecule: ChemistryMolecule) {
        sceneView.isHidden = false
        atomTitle.isHidden = true
        atomDescription.isHidden = true
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        sceneView.scene!.rootNode.addChildNode(cameraNode)
        
        let node = drawChemistryMolecule(molecule)
        sceneView.scene!.rootNode.addChildNode(node)
        node.rotation = SCNVector4(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
    }
    
    func show(atom: ChemistryAtom) {
        sceneView.isHidden = true
        atomTitle.isHidden = false
        atomDescription.isHidden = false
        
        progressIndicator.isHidden = false
        
        atomTitle.stringValue = atom.title.base!
        
        let _ = WikipediaQuery().getExtract(atom.title.base!) { data in
            return Result {
                let pageId = Array(data.query.pages.keys)[0]
                let extract = data.query.pages[pageId]?.extract
                
                self.atomDescription.string = extract ?? ""
                
                self.progressIndicator.isHidden = true
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

protocol DetailDelegate {
    func show(molecule: ChemistryMolecule)
    func show(atom: ChemistryAtom)
}
