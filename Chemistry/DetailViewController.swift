//
//  DetailViewController.swift
//  Chemistry
//
//  Created by Паша Косило on 10/21/18.
//  Copyright © 2018 Pavel Kosilo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import WebKit
import ChemistryShared

enum DetailViewControllerMode {
    case molecule
    case atom
    case none
}

enum SceneViewMode {
    case scn
    case ar
}

class DetailViewController: UIViewController, WKUIDelegate {
    
    var sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 512, height: 512))
    @IBOutlet weak var scnSwitch: UIButton!
    var webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 512, height: 512))
    
    var mode = DetailViewControllerMode.none
    
    func configureSceneView(node: SCNNode) {
        sceneView = SCNView(frame: view.bounds)
        
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
            self.sceneView.removeFromSuperview()
            configureSceneView(node: drawChemistryMolecule(detailMolecule!))
            self.webView.removeFromSuperview()
            self.view.insertSubview(sceneView, belowSubview: scnSwitch)
            sceneView.autoresizingMask = .init(arrayLiteral: .flexibleWidth, .flexibleHeight)
        } else if mode == .atom { // Is it in Atoms
            self.webView.removeFromSuperview()
            self.title = NSLocalizedString((detailAtom?.title.base!)!, comment: "")
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
            self.sceneView.removeFromSuperview()
            self.view.insertSubview(webView, belowSubview: scnSwitch)
            webView.autoresizingMask = .init(arrayLiteral: .flexibleWidth, .flexibleHeight)
            
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
    
    @IBAction func reloadAction() {
        configureView()
    }


}

