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

class DetailViewController: NSViewController, DetailDelegate {
    var sceneView = SCNView()
    
    func show(molecule: ChemistryMolecule) {
        let sceneView = SCNView(frame: view.frame)
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
        
        view.subviews = [view.subviews[0]]
        view.addSubview(sceneView)
        sceneView.autoresizingMask = .init(arrayLiteral: .height, .width)
    }
    
    func show(atom: ChemistryAtom) {
        
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
