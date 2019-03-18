//
//  DetailViewController.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import UIKit
import SceneKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 512, height: 512))
    
    func configureSceneView(node: SCNNode) {
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        sceneView.scene!.rootNode.addChildNode(cameraNode)
        
        sceneView.scene!.rootNode.addChildNode(node)
        
        node.rotation = SCNVector4(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
    }
    
    func configureView() {
        self.view = sceneView
        // Update the user interface for the detail item.
        if let detail = detailItem { // Check detailization item active
            if let molecule = Molecules[detail] { // Is it in Molecules
                configureSceneView(node: molecule)
            } else {
                if let atom = Atoms[detail]?.draw().ToNode() { // Is it in Atoms
                    configureSceneView(node: atom)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            self.title = detailItem
            configureView()
        }
    }


}

