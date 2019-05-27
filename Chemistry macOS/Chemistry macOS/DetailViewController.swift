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
        sceneView.backgroundColor = .clear
        
        let scene = SCNScene()
        scene.background.contents = NSColor.clear
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
        
        sceneView.isHidden = false
        atomTitle.isHidden = true
        atomDescription.isHidden = true
    }
    
    func show(atom: ChemistryAtom) {
        progressIndicator.isHidden = false
        
        atomTitle.stringValue = atom.title.base!
        
        let _ = WikipediaQuery().getExtract(atom.title.base!) { data in
            return Result {
                let pageId = Array(data.query.pages.keys)[0]
                let extract = data.query.pages[pageId]?.extract
                
                self.atomDescription.string = extract ?? ""
                
                self.progressIndicator.isHidden = true
                
                sceneView.isHidden = true
                atomTitle.isHidden = false
                atomDescription.isHidden = false
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

extension String{
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        return NSAttributedString(html: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html], documentAttributes: nil) ?? NSAttributedString()
    }
}
