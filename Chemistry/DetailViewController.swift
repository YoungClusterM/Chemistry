//
//  DetailViewController.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import UIKit
import SceneKit
import WebKit
import ChemistryShared

enum DetailViewControllerMode {
    case molecule
    case atom
    case none
}

class DetailViewController: UIViewController, WKUIDelegate {
    
    var sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 512, height: 512))
    
    var mode = DetailViewControllerMode.none
    
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
        self.navigationItem.largeTitleDisplayMode = .never
        if mode == .molecule { // Is it in Molecules
            self.view = sceneView
            configureSceneView(node: drawChemistryMolecule(detailMolecule!))
        } else if mode == .atom { // Is it in Atoms
            self.title = NSLocalizedString((detailAtom?.title.base!)!, comment: "")
            let webConfiguration = WKWebViewConfiguration()
            let webView = WKWebView(frame: .zero, configuration: webConfiguration)
            self.view = webView
            
            let link = "https://en.wikipedia.org/wiki/"
            let myURL = URL(string:link + (detailAtom?.title.base!)!)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        } else {
            print("Nothing to configure")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailAtom: ChemistryAtom? {
        didSet {
            mode = .atom
            // Update the view.
            self.title = detailAtom?.title.base!
            configureView()
        }
    }
    
    var detailMolecule: ChemistryMolecule? {
        didSet {
            mode = .molecule
            // Update the view.
            self.title = detailMolecule?.title
            configureView()
        }
    }


}

